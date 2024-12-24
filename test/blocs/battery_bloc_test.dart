import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/battery_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:enpal/data/storage/cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MonitoringRepository mockMonitoringRepo;
  late UnitPreferenceCubit mockUnitPreferenceCubit;
  late BatteryBloc batteryBloc;

  setUp(() {
    AppDatabase database = AppDatabase();
    mockMonitoringRepo = MonitoringRepository(db: database);
    mockUnitPreferenceCubit = UnitPreferenceCubit();

    when(() => mockUnitPreferenceCubit.state).thenReturn('watts');

    batteryBloc = BatteryBloc(
      monitoringRepo: mockMonitoringRepo,
      unitPreferenceCubit: mockUnitPreferenceCubit,
    );
  });

  tearDown(() {
    batteryBloc.close();
  });

  group('BatteryBloc Tests', () {
    blocTest<BatteryBloc, MonitoringState>(
      'emits [MonitoringDataIsLoading, MonitoringData] when FetchMonitoringDataEvent is added',
      setUp: () {
        final mockData = [
          MonitoringData(value: 500, timestamp: DateTime(2024, 12, 22)),
          MonitoringData(value: 300, timestamp: DateTime(2024, 12, 22)),
        ];

        when(() => mockMonitoringRepo.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
            )).thenAnswer((_) async => mockData);
      },
      build: () => batteryBloc,
      act: (bloc) => bloc.add(FetchMonitoringDataEvent(
        type: 'battery',
        date: '2024-12-22',
      )),
      expect: () => [
        MonitoringDataIsLoading(),
        isA<MonitoringData>()
            .having((state) => state., 'graphData length', 2)
            .having((state) => state.totalEnergy, 'totalEnergy', 800.0),
      ],
      verify: (_) {
        verify(() => mockMonitoringRepo.getMonitoringData(
              date: '2024-12-22',
              type: 'battery',
            )).called(1);
      },
    );

    blocTest<BatteryBloc, MonitoringState>(
      'emits [MonitoringDataFailed] when repository throws an error during FetchMonitoringDataEvent',
      setUp: () {
        when(() => mockMonitoringRepo.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
            )).thenThrow(Exception('Error fetching data'));
      },
      build: () => batteryBloc,
      act: (bloc) => bloc.add(FetchMonitoringDataEvent(
        type: 'battery',
        date: '2024-12-22',
      )),
      expect: () => [
        MonitoringDataIsLoading(),
        MonitoringDataFailed(
            'Failed to fetch data: Exception: Error fetching data'),
      ],
    );

    blocTest<BatteryBloc, MonitoringState>(
      'emits [MonitoringDataSuccessfull] when MonitoringDataPollEvent is added',
      setUp: () {
        final mockData = [
          MonitoringData(value: 200, timestamp: DateTime(2024, 12, 22)),
          MonitoringData(value: 400, timestamp: DateTime(2024, 12, 22)),
        ];

        when(() => mockMonitoringRepo.getMonitoringData(
              date: any(named: 'date'),
              type: any(named: 'type'),
            )).thenAnswer((_) async => mockData);
      },
      build: () => batteryBloc,
      act: (bloc) => bloc.add(MonitoringDataPollEvent('battery')),
      expect: () => [
        isA<MonitoringData>()
            .having((state) => state.data.length, 'graphData length', 2)
            .having((state) => state.totalEnergy, 'totalEnergy', 600.0),
      ],
    );

    blocTest<BatteryBloc, MonitoringState>(
      'calls startPolling when checkIfPolling is called and no active timer exists',
      setUp: () {
        batteryBloc.closePolling();
      },
      build: () => batteryBloc,
      act: (bloc) => bloc.checkIfPolling('battery'),
      verify: (_) {
        expect(batteryBloc.timer?.isActive, isTrue);
      },
    );
  });
}
