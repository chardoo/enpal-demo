import 'dart:async';

import 'package:enpal/bloc/battery/monitoring_event.dart';
import 'package:enpal/bloc/monitoring_state.dart';
import 'package:enpal/data/repository/monitoring_repo.dart';
import 'package:enpal/utils/datautils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  // static final BatteryBloc _instance = BatteryBloc._internal();
  MonitoringBloc() : super(Initial()) {
    on<FetchMonitoringDataEvent>(_onBatteryDataFetchHandler);
    on<MonitoringDataPollEvent>(_onBatteryDataPoll);

    _startPolling();
  }

  // factory BatteryBloc() => _instance;

  final MonitoringRepo _monitoringRepo = MonitoringRepo();
  Timer? _timer;

  void _onBatteryDataFetchHandler(
      FetchMonitoringDataEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringDataIsLoading());
    // close the polling if filtering is happeining
    if (todayDateFormat() != event.date) {
      closePolling();
    } else {
      checkifPolling();
    }
    try {
      final data = await _monitoringRepo.getMonitoringData(
        date: event.date,
        type: "battery",
      );
      int totalEnergy = 0;
      for (var number in data) {
        totalEnergy += number.value;
      }

      emit(MonitoringDataSuccessfull(data, totalEnergy));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch battery data'));
    }
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
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
      int totalEnergy = 0;
      for (var number in data) {
        totalEnergy += number.value;
      }
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

  closePolling() {
    _timer?.cancel();
  }

  checkifPolling() {
    print("about to poll agian");
    if (!_timer!.isActive || _timer?.isActive == null) {
      print("starting polling agian man");
      _startPolling();
    }
  }
}
