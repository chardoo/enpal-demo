import 'dart:async';
import 'package:dio/dio.dart';

class Api {
 late Dio dio;

  // Singleton instance
  Api._internal() {
    dio = _createDio();
  }

  static final Api _instance = Api._internal();

  factory Api() => _instance;

  // Reset Dio for testing
  void resetDio(Dio mockDio) {
    dio = mockDio;
  }

  // Create a default Dio instance
  Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://94e3-193-148-48-113.ngrok-free.app",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    )..interceptors.add(AppInterceptors());
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
    });

    print('Request [${options.method}] => PATH: ${options.path}');
    handler.next(options); // Continue request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response [${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response); // Pass the response forward
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print('Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

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
          message: 'An unexpected error occurred: ${err.message}',
        ));
        break;
    }
  }
}

// Exception classes for specific error types
class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Bad Request: The server could not understand the request.';
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Unauthorized: Access is denied.';
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Not Found: The requested resource could not be located.';
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Conflict: The request could not be processed due to a conflict.';
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Internal Server Error: An unexpected error occurred on the server.';
}
