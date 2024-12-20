import 'dart:async';

import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:enpal/utils/dateutils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 abstract class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {

  MonitoringBloc() : super(Initial()) {
    on<FetchMonitoringDataEvent>(_onBatteryDataFetchHandler);
    on<MonitoringDataPollEvent>(_onBatteryDataPoll);

    // Start polling when the bloc is instantiated
    _startPolling();
  }

  final MonitoringRepo _monitoringRepo = MonitoringRepo();
  Timer? _timer;

  void _onBatteryDataFetchHandler(
      FetchMonitoringDataEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringDataIsLoading());
    
    // Close polling if filtering is happening
    if (todayDateFormat() != event.date) {
      closePolling();
    } else {
      checkIfPolling();
    }

    try {
      final data = await _monitoringRepo.getMonitoringData(
        date: event.date,
        type: "battery",
      );

      int totalEnergy = data.fold(0, (sum, item) => sum + item.value);

      emit(MonitoringDataSuccessfull(data, totalEnergy));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch battery data'));
    }
  }

  void _startPolling() {
    _timer ??= Timer.periodic(const Duration(seconds: 3), (timer) {
      add(MonitoringDataPollEvent());
    });
  }

  void _onBatteryDataPoll(
      MonitoringDataPollEvent event, Emitter<MonitoringState> emit) async {
    try {
      final data = await _monitoringRepo.getMonitoringData(
        date: todayDateFormat(),
        type: "battery",
      );
      int totalEnergy = data.fold(0, (sum, item) => sum + item.value);
      emit(MonitoringDataSuccessfull(data, totalEnergy));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch battery data'));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void closePolling() {
    _timer?.cancel();
    _timer = null; // Reset the timer to allow re-initialization
  }

  void checkIfPolling() {
    if (_timer == null || !_timer!.isActive) {
      _startPolling();
    }
  }
}
