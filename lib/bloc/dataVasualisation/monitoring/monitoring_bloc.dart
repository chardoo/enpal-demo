import 'dart:async';
import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:enpal/utils/dateutils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Abstract class representing a monitoring BLoC for handling events and states
/// related to data visualisation in a monitoring context.
abstract class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  final MonitoringRepository monitoringRepo;
  final UnitPreferenceCubit unitPreferenceCubit;
  Timer? timer;
  final int pollingInterval;

  MonitoringBloc({
    required this.monitoringRepo,
    required this.unitPreferenceCubit,
    this.pollingInterval = 5,
  }) : super(Initial()) {
    on<FetchMonitoringDataEvent>(_onDataFetchHandler);
    on<MonitoringDataPollEvent>(_onDataPollHandler);
  }

  void _onDataFetchHandler(
      FetchMonitoringDataEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringDataIsLoading());

    if (todayDateFormat() != event.date) {
      closePolling();
    } else {
      checkIfPolling(event.type);
    }

    try {
      final data = await monitoringRepo.getMonitoringData(
        date: event.date,
        type: event.type,
      );
      emit(_transformData(data));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch data: ${e.toString()}'));
    }
  }

  void startPolling(String type) {
    closePolling(); // Avoid duplicate timers
    timer = Timer.periodic(Duration(seconds: pollingInterval), (_) {
      add(MonitoringDataPollEvent(type));
    });
  }

  void _onDataPollHandler(
      MonitoringDataPollEvent event, Emitter<MonitoringState> emit) async {
    try {
      final data = await monitoringRepo.getMonitoringData(
        date: todayDateFormat(),
        type: event.type,
      );
      emit(_transformData(data));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch data: ${e.toString()}'));
    }
  }

  MonitoringDataSuccessfull _transformData(List<MonitoringData> data) {
    final unit = unitPreferenceCubit.state;
    final graphData = (unit == 'kw')
        ? data
            .map((item) =>
                MonitoringData(value: item.value / 1000, timestamp: item.timestamp))
            .toList()
        : data;
    final totalEnergy = graphData.fold(0.0, (sum, item) => sum + item.value);
    return MonitoringDataSuccessfull(graphData, totalEnergy, unit);
  }

  void closePolling() {
    timer?.cancel();
    timer = null;
  }

  void checkIfPolling(String type) {
    if (timer == null || !timer!.isActive) {
      startPolling(type);
    }
  }

  @override
  Future<void> close() {
    closePolling();
    return super.close();
  }
}
