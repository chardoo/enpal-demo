import 'package:dio/dio.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/dio_client.dart';
import 'package:enpal/data/repository/i_monitoring_repo.dart';

class MonitoringRepo implements MonitoringRepository {
  MonitoringRepo._internal();
  static final MonitoringRepo _instance = MonitoringRepo._internal();
  factory MonitoringRepo() => _instance;

  @override
  Future<List<MonitoringData>> getMonitoringData({
    required String date,
    required String type,
  }) async {
    try {
      final response = await Api().dio.get(
        '/monitoring',
        queryParameters: {"date": date, "type": type},
      );
   
      if (response.data is List) {
        return (response.data as List)
            .map((item) => MonitoringData.fromjson(item))
            .toList();
      } else {
        throw Exception('Invalid data format: Expected a list');
      }
    } on DioException {
      throw Exception('error happend ');
    } catch (_) {
      throw Exception('error happend ');
    }
  }
}
