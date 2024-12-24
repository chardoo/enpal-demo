import 'package:dio/dio.dart';
import 'package:enpal/core/constants/api_constant.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/dio_client.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:enpal/data/storage/cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late MonitoringRepository monitoringRepository;
  late AppDatabase database;

  setUpAll(() {
    // Initialize shared AppDatabase instance
    database = AppDatabase();
  });

  setUp(() {
    // Create a fresh mock Dio for each test
    mockDio = MockDio();

    // Reset Dio in the Api class
    Api().resetDio(mockDio);

    // Create a MonitoringRepository instance with the shared AppDatabase
    monitoringRepository = MonitoringRepository(db: database);
  });

  tearDownAll(() async {
    await database.close(); // Ensure database is closed after all tests
  });

  group('MonitoringRepository - getMonitoringData', () {
    const String date = '2024-12-22';
    const String type = 'battery';

    test('returns a list of MonitoringData when API response is successful',
        () async {
      // Arrange
      final mockResponseData = [
        {"value": 500, "timestamp": "2024-12-22T10:00:00.000Z"},
        {"value": 300, "timestamp": "2024-12-22T11:00:00.000Z"}
      ];
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiConstants.monitoringEndpoint),
        statusCode: 200,
        data: mockResponseData,
      );

      when(() => mockDio.get(
            ApiConstants.monitoringEndpoint,
            queryParameters: {"date": date, "type": type},
          )).thenAnswer((_) async => mockResponse);

      // Act
      final result =
          await monitoringRepository.getMonitoringData(date: date, type: type);

      // Assert
      expect(result, isA<List<MonitoringData>>());
      expect(result.length, 2);
      expect(result.first.value, 500);
      expect(
          result.first.timestamp, DateTime.parse("2024-12-22T10:00:00.000Z"));
    });

    test('throws an exception when API response data is not a list', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiConstants.monitoringEndpoint),
        statusCode: 200,
        data: {"key": "value"}, // Invalid format
      );

      when(() => mockDio.get(
            ApiConstants.monitoringEndpoint,
            queryParameters: {"date": date, "type": type},
          )).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () async => await monitoringRepository.getMonitoringData(
            date: date, type: type),
        throwsA(isA<Exception>().having(
            (e) => e.toString(), 'message', contains('Invalid data format'))),
      );
    });

    test('throws an exception when Dio throws a DioException', () async {
      // Arrange
      when(() => mockDio.get(
            ApiConstants.monitoringEndpoint,
            queryParameters: {"date": date, "type": type},
          )).thenThrow(DioException(
        requestOptions: RequestOptions(path: ApiConstants.monitoringEndpoint),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ApiConstants.monitoringEndpoint),
          statusCode: 500,
          data: 'Internal Server Error',
        ),
      ));

      // Act & Assert
      expect(
        () async => await monitoringRepository.getMonitoringData(
            date: date, type: type),
        throwsA(isA<Exception>()
            .having((e) => e.toString(), 'message', contains('API Error'))),
      );
    });

    test('throws an exception when an unexpected error occurs', () async {
      // Arrange
      when(() => mockDio.get(
            ApiConstants.monitoringEndpoint,
            queryParameters: {"date": date, "type": type},
          )).thenThrow(Exception('Unexpected Error'));

      // Act & Assert
      expect(
        () async => await monitoringRepository.getMonitoringData(
            date: date, type: type),
        throwsA(isA<Exception>().having(
            (e) => e.toString(), 'message', contains('Unexpected Error'))),
      );
    });
  });
}
