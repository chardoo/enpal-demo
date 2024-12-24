// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// ignore_for_file: type=lint
class $MonitoringCacheTable extends MonitoringCache
    with TableInfo<$MonitoringCacheTable, MonitoringCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonitoringCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, value, timestamp, key];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monitoring_cache';
  @override
  VerificationContext validateIntegrity(
      Insertable<MonitoringCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonitoringCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonitoringCacheData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
    );
  }

  @override
  $MonitoringCacheTable createAlias(String alias) {
    return $MonitoringCacheTable(attachedDatabase, alias);
  }
}

class MonitoringCacheData extends DataClass
    implements Insertable<MonitoringCacheData> {
  final int id;
  final double value;
  final DateTime timestamp;
  final String key;
  const MonitoringCacheData(
      {required this.id,
      required this.value,
      required this.timestamp,
      required this.key});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<double>(value);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['key'] = Variable<String>(key);
    return map;
  }

  MonitoringCacheCompanion toCompanion(bool nullToAbsent) {
    return MonitoringCacheCompanion(
      id: Value(id),
      value: Value(value),
      timestamp: Value(timestamp),
      key: Value(key),
    );
  }

  factory MonitoringCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonitoringCacheData(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<double>(json['value']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      key: serializer.fromJson<String>(json['key']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<double>(value),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'key': serializer.toJson<String>(key),
    };
  }

  MonitoringCacheData copyWith(
          {int? id, double? value, DateTime? timestamp, String? key}) =>
      MonitoringCacheData(
        id: id ?? this.id,
        value: value ?? this.value,
        timestamp: timestamp ?? this.timestamp,
        key: key ?? this.key,
      );
  MonitoringCacheData copyWithCompanion(MonitoringCacheCompanion data) {
    return MonitoringCacheData(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      key: data.key.present ? data.key.value : this.key,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonitoringCacheData(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value, timestamp, key);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonitoringCacheData &&
          other.id == this.id &&
          other.value == this.value &&
          other.timestamp == this.timestamp &&
          other.key == this.key);
}

class MonitoringCacheCompanion extends UpdateCompanion<MonitoringCacheData> {
  final Value<int> id;
  final Value<double> value;
  final Value<DateTime> timestamp;
  final Value<String> key;
  const MonitoringCacheCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.key = const Value.absent(),
  });
  MonitoringCacheCompanion.insert({
    this.id = const Value.absent(),
    required double value,
    required DateTime timestamp,
    required String key,
  })  : value = Value(value),
        timestamp = Value(timestamp),
        key = Value(key);
  static Insertable<MonitoringCacheData> custom({
    Expression<int>? id,
    Expression<double>? value,
    Expression<DateTime>? timestamp,
    Expression<String>? key,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (timestamp != null) 'timestamp': timestamp,
      if (key != null) 'key': key,
    });
  }

  MonitoringCacheCompanion copyWith(
      {Value<int>? id,
      Value<double>? value,
      Value<DateTime>? timestamp,
      Value<String>? key}) {
    return MonitoringCacheCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      key: key ?? this.key,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonitoringCacheCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('timestamp: $timestamp, ')
          ..write('key: $key')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MonitoringCacheTable monitoringCache =
      $MonitoringCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [monitoringCache];
}

typedef $$MonitoringCacheTableCreateCompanionBuilder = MonitoringCacheCompanion
    Function({
  Value<int> id,
  required double value,
  required DateTime timestamp,
  required String key,
});
typedef $$MonitoringCacheTableUpdateCompanionBuilder = MonitoringCacheCompanion
    Function({
  Value<int> id,
  Value<double> value,
  Value<DateTime> timestamp,
  Value<String> key,
});

class $$MonitoringCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MonitoringCacheTable> {
  $$MonitoringCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));
}

class $$MonitoringCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MonitoringCacheTable> {
  $$MonitoringCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));
}

class $$MonitoringCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonitoringCacheTable> {
  $$MonitoringCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);
}

class $$MonitoringCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonitoringCacheTable,
    MonitoringCacheData,
    $$MonitoringCacheTableFilterComposer,
    $$MonitoringCacheTableOrderingComposer,
    $$MonitoringCacheTableAnnotationComposer,
    $$MonitoringCacheTableCreateCompanionBuilder,
    $$MonitoringCacheTableUpdateCompanionBuilder,
    (
      MonitoringCacheData,
      BaseReferences<_$AppDatabase, $MonitoringCacheTable, MonitoringCacheData>
    ),
    MonitoringCacheData,
    PrefetchHooks Function()> {
  $$MonitoringCacheTableTableManager(
      _$AppDatabase db, $MonitoringCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonitoringCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonitoringCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonitoringCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String> key = const Value.absent(),
          }) =>
              MonitoringCacheCompanion(
            id: id,
            value: value,
            timestamp: timestamp,
            key: key,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double value,
            required DateTime timestamp,
            required String key,
          }) =>
              MonitoringCacheCompanion.insert(
            id: id,
            value: value,
            timestamp: timestamp,
            key: key,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MonitoringCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MonitoringCacheTable,
    MonitoringCacheData,
    $$MonitoringCacheTableFilterComposer,
    $$MonitoringCacheTableOrderingComposer,
    $$MonitoringCacheTableAnnotationComposer,
    $$MonitoringCacheTableCreateCompanionBuilder,
    $$MonitoringCacheTableUpdateCompanionBuilder,
    (
      MonitoringCacheData,
      BaseReferences<_$AppDatabase, $MonitoringCacheTable, MonitoringCacheData>
    ),
    MonitoringCacheData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MonitoringCacheTableTableManager get monitoringCache =>
      $$MonitoringCacheTableTableManager(_db, _db.monitoringCache);
}
