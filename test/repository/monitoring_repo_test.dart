import 'package:dio/dio.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'monitoring_repo_test.mocks.dart';

void main() {
    TestWidgetsFlutterBinding.ensureInitialized();
  group('MonitoringRepo Tests', () {
    

    test('getMonitoringData returns a list of MonitoringData on success', () async {
      // Arrange
      final date = '2024-12-16';
      final type = 'battery';
      final responseData = [
        {"timestamp": "2024-12-16T00:00:00.000Z", "value": 8003},
        {"timestamp": "2024-12-16T00:05:00.000Z", "value": 8610},
      ];

      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/monitoring'),
      );

      when(mockDio.get(
        '/monitoring',
        queryParameters: {"date": date, "type": type},
      )).thenAnswer((_) async => response);

 
      final result = await monitoringRepo.getMonitoringData(date: date, type: type);

     
      expect(result, isA<List<MonitoringData>>());
      expect(result.length, 2);
      expect(result[0].value, 8003);
      expect(result[1].value, 8610);
    });

    test('getMonitoringData throws an exception when response data is not a list', () async {

      final date = '2024-12-16';
      final type = 'battery';
      final response = Response(
        data: {"timestamp": "2024-12-16T00:00:00.000Z", "value": 8003},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/monitoring'),
      );

      when(mockDio.get(
        '/monitoring',
        queryParameters: {"date": date, "type": type},
      )).thenAnswer((_) async => response);

      // Act & Assert
      expect(
        () async => await monitoringRepo.getMonitoringData(date: date, type: type),
        throwsException,
      );
    });

    test('getMonitoringData throws an exception on DioException', () async {
     
      final date = '2024-12-16';
      final type = 'battery';

      when(mockDio.get(
        '/monitoring',
        queryParameters: {"date": date, "type": type},
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/monitoring'),
        type: DioExceptionType.connectionTimeout,
      ));

  
      expect(
        () async => await monitoringRepo.getMonitoringData(date: date, type: type),
        throwsException,
      );
    });
  });
}
