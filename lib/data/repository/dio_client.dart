import 'dart:async';
import 'package:dio/dio.dart';

class Api {
  late final Dio dio;

  // Singleton instance
  Api._internal() : dio = _createDio();

  static final Api _singleton = Api._internal();

  factory Api() => _singleton;

  // Create and configure Dio instance
  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: "http://localhost:3000",
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    )..interceptors.add(AppInterceptors());
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Access-Control-Allow-Origin'] = '*';
    options.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE, HEAD';

    print('Sending request to ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response received: ${response.statusCode}');
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print('Error occurred: ${err.response?.statusCode} - ${err.message}');
    
    // Handle specific HTTP status codes
    switch (err.response?.statusCode) {
      case 400:
        handler.reject(BadRequestException(err.requestOptions));
        break;
      case 401:
        handler.reject(UnauthorizedException(err.requestOptions));
        break;
      case 404:
        handler.reject(NotFoundException(err.requestOptions));
        break;
      case 409:
        handler.reject(ConflictException(err.requestOptions));
        break;
      case 500:
        handler.reject(InternalServerErrorException(err.requestOptions));
        break;
      default:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          message: 'An unexpected error occurred.',
        ));
        break;
    }
  }
}

// Exception classes
class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Invalid request';
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Access denied';
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'The requested information could not be found';
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Conflict occurred';
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Unknown error occurred, please try again later.';
}
