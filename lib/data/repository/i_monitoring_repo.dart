
import 'package:enpal/data/models/monitoring_data.dart';

/// Abstract class representing a repository for fetching monitoring data.
///
/// This repository provides a contract for retrieving monitoring data, such as
/// battery, solar, and house data, based on a specific date and type.
///from an API,
abstract class MonitoringRepository {
  /// Retrieves monitoring data based on the provided [date] and [type].
  ///
  /// Parameters:
  /// - [date]: The date for which to retrieve the monitoring data (format: `yyyy-MM-dd`).
  /// - [type]: The type of monitoring data to retrieve (e.g., "battery", "solar", "house").
  ///
  /// Returns:
  /// A [Future] that resolves to a list of [MonitoringData] objects.

  /// Throws:
  /// - An exception if the data retrieval fails.
  Future<List<MonitoringData>> getMonitoringData({
    required String date,
    required String type,
  });
}
