import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // Use this for non-Flutter platforms
import 'package:drift_flutter/drift_flutter.dart'; // Required for Flutter platforms
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'cache.g.dart';

// Define the `MonitoringCache` table for caching data
class MonitoringCache extends Table {
  IntColumn get id => integer()
      .autoIncrement()(); // Unique cache key (e.g., '2024-12-22-battery')
  RealColumn get value => real()(); // Value (e.g., energy consumption)
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get key => text()(); // Timestamp for cache expiry tracking

  // @override
  // Set<Column> get primaryKey => {key};
}

// Drift Database
@DriftDatabase(tables: [MonitoringCache])
class AppDatabase extends _$AppDatabase {
 

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Clear all cached data
  Future<void> clearCache() => delete(monitoringCache).go();

  /// Save a single entry in the cache
  Future<void> saveCache(String key, double value, DateTime timestamp) async {
    await into(monitoringCache).insert(
      MonitoringCacheCompanion(
        key: Value(key),
        value: Value(value),
        timestamp: Value(timestamp),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> saveCacheBatch(List<MonitoringCacheCompanion> records) async {
    await batch((batch) {
      batch.insertAll(
        monitoringCache,
        records,
        mode: InsertMode
            .insertOrReplace, // Ensures records are replaced if the key already exists
      );
    });
  }

  /// Retrieve cached data by key
  Future<List<MonitoringData>> getCache(String key) async {
    final result = await (select(monitoringCache)
          ..where((tbl) => tbl.key.equals(key)))
        .get();
    final cacheData = result.map(
      (e) {
        return MonitoringData(value: e.value, timestamp: e.timestamp);
      },
    ).toList();
    if (cacheData.isNotEmpty) {
      return cacheData;
    }
    return [];
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
