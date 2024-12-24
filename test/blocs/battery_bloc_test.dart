import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/battery_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/i_monitoring_repo.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMonitoringRepository extends Mock implements MonitoringRepository {}

class MockUnitPreferenceCubit extends MockCubit<String>
    implements UnitPreferenceCubit {}

void main() {
  late MockMonitoringRepository mockMonitoringRepo;
  late MockUnitPreferenceCubit mockUnitPreferenceCubit;

  // Set up fallback values for mocked events
  setUpAll(() {
    registerFallbackValue(FetchMonitoringDataEvent(type: 'battery', date: '2024-12-22'));
    registerFallbackValue(MonitoringDataPollEvent('battery'));
  });

  setUp(() {
    mockMonitoringRepo = MockMonitoringRepository();
    mockUnitPreferenceCubit = MockUnitPreferenceCubit();

    // Mock initial state of UnitPreferenceCubit
    when(() => mockUnitPreferenceCubit.state).thenReturn('watts');
  });

  tearDown(() {
    // Ensure resources are properly released
    mockMonitoringRepo = MockMonitoringRepository();
    mockUnitPreferenceCubit = MockUnitPreferenceCubit();
  });

  group('BatteryBloc Tests', () {
    blocTest<BatteryBloc, MonitoringState>(
      'emits [MonitoringDataIsLoading, MonitoringDataSuccessfull] when FetchMonitoringDataEvent is added',
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
      build: () => BatteryBloc(
        monitoringRepo: mockMonitoringRepo,
        unitPreferenceCubit: mockUnitPreferenceCubit,
      ),
      act: (bloc) => bloc.add(FetchMonitoringDataEvent(
        type: 'battery',
        date: '2024-12-22',
      )),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MonitoringDataIsLoading(),
        isA<DataSuccessful>()
            .having((state) => state.data.length, 'data length', 2)
            .having((state) => state.totalEnergy, 'totalEnergy', 800.0),
      ],
      verify: (_) {
        verify(() => mockMonitoringRepo.getMonitoringData(
              date: '2024-12-22',
              type: 'battery',
            )).called(1);
      },
    );


    test('calls startPolling when checkIfPolling is called and no active timer exists', () {
      final bloc = BatteryBloc(
        monitoringRepo: mockMonitoringRepo,
        unitPreferenceCubit: mockUnitPreferenceCubit,
      );

      bloc.closePolling();

      bloc.checkIfPolling('battery');

      expect(bloc.timer?.isActive, isTrue);

      bloc.close();
    });
  });
}
