import 'package:dio/dio.dart';
import 'package:enpal/core/constants/api_constant.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/dio_client.dart';
import 'package:enpal/data/repository/i_monitoring_repo.dart';

class MonitoringRepository implements IMonitoringRepository {
  MonitoringRepository._internal();
  static final MonitoringRepository _instance = MonitoringRepository._internal();
  factory MonitoringRepository() => _instance;

  @override
  Future<List<MonitoringData>> getMonitoringData({
    required String date,
    required String type,
  }) async {
    try {
      final response = await Api().dio.get(
       ApiConstants.monitoringEndpoint,
        queryParameters: {"date": date, "type": type},
      );

      if (response.data is List) {
        return (response.data as List)
            .map((item) => MonitoringData.fromjson(item))
            .toList();
      } else {
        throw Exception('Invalid data format: Expected a list.');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected Error: ${e.toString()}');
    }
  }
}
