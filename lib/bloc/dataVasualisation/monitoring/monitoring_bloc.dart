
import 'dart:async';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/data/models/monitoring_data.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:enpal/utils/dateutils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Abstract class representing a monitoring BLoC for handling events and states
/// related to data visualisation in a monitoring context.
abstract class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  MonitoringBloc() : super(Initial()) {
    on<FetchMonitoringDataEvent>(_onBatteryDataFetchHandler);
    on<MonitoringDataPollEvent>(_onBatteryDataPoll);
  }

  final MonitoringRepo _monitoringRepo = MonitoringRepo();
  Timer? timer;
  String unit = 'watts';

  void _onBatteryDataFetchHandler(
      FetchMonitoringDataEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringDataIsLoading());

    if (todayDateFormat() != event.date) {
      closePolling();
    } else {
      checkIfPolling(event.type);
    }
    try {
      final data = await getMonitoringData(event);
      final monitoringDataSuccesfulevent = transformValueAndGetTotal(data);
      emit(monitoringDataSuccesfulevent);
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch battery data'));
    }
  }

  void startPolling(String type) {
    timer ??= Timer.periodic(const Duration(seconds: 3), (timer) {
      add(MonitoringDataPollEvent(type));
    });
  }

  void _onBatteryDataPoll(
      MonitoringDataPollEvent event, Emitter<MonitoringState> emit) async {
    try {
      final data = await _monitoringRepo.getMonitoringData(
        date: todayDateFormat(),
        type: event.type,
      );
      final monitoringDataSuccesfulevent = transformValueAndGetTotal(data);
      emit(monitoringDataSuccesfulevent);
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch battery data'));
    }
  }

  Future<List<MonitoringData>> getMonitoringData(FetchMonitoringDataEvent event) async {
    final data = await _monitoringRepo.getMonitoringData(
      date: event.date,
      type: event.type,
    );
    return data;
  }

  MonitoringDataSuccessfull transformValueAndGetTotal(List<MonitoringData> data) {
    List<MonitoringData> graphData;
    if (unit == "kw") {
      graphData = data.map((element) => MonitoringData(
          value: (element.value / 1000), timestamp: element.timestamp)).toList();
    } else {
      graphData = data;
    }
    double totalEnergy = graphData.fold(0, (sum, item) => sum + item.value);
    final success = MonitoringDataSuccessfull(graphData, totalEnergy, unit);
    return success;
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  void closePolling() {
    timer?.cancel();
    timer = null; // Reset the timer to allow re-initialization
  }

  void checkIfPolling(String type) {
    if (timer == null || !timer!.isActive) {
      startPolling(type);
    }
  }
}
