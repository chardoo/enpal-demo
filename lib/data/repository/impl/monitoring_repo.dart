import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:enpal/core/constants/api_constant.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/dio_client.dart';
import 'package:enpal/data/repository/i_monitoring_repo.dart';
import 'package:enpal/data/storage/cache.dart';

class MonitoringRepository implements IMonitoringRepository {
  final AppDatabase db;
  MonitoringRepository._internal({required this.db});
  static MonitoringRepository? _instance;
  factory MonitoringRepository({required AppDatabase db}) {
    _instance ??= MonitoringRepository._internal(db: db);
    return _instance!;
  }

  @override
  Future<List<MonitoringData>> getMonitoringData({
    required String date,
    required String type,
  }) async {
    final cacheKey = '$date-$type';

    // Step 1: Check the cache
   // await db.clearCache();
    // final cachedData = await db.getCache(cacheKey);
    // if (cachedData.isNotEmpty) {
    //   print(cachedData.length);
    //   return cachedData;
    // }

    try {
      final response = await Api().dio.get(
        ApiConstants.monitoringEndpoint,
        queryParameters: {"date": date, "type": type},
      );

      if (response.data is List) {
        final data = (response.data as List)
            .map((item) => MonitoringData.fromJson(item))
            .toList();
        // final records = data.map((item) {
        //   return MonitoringCacheCompanion(
        //     key: Value(cacheKey),
        //     value: Value(item.value),
        //     timestamp: Value(item.timestamp),
        //   );
        // }).toList();

      //  await db.saveCacheBatch(records);
        return data;
      } else {
        throw Exception('Invalid data format: Expected a list.');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected Error: ${e.toString()}');
    }
  }

  /// Clears the cache for all stored data
  Future<void> clearCache() async {
    await db.clearCache();
  }
}
