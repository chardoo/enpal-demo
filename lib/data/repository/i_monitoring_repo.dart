import 'package:enpal/data/models/monitoring_data.dart';

abstract class MonitoringRepository {
  Future<List<MonitoringData>> getMonitoringData({
    required String date,
    required String type,
  });
}
