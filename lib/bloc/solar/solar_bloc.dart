import 'dart:math';

import 'package:enpal/bloc/solar/solar_event.dart';
import 'package:enpal/bloc/monitoring_state.dart';
import 'package:enpal/data/repository/monitoring_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolarBloc extends Bloc<SolarEvent, MonitoringState> {
  static final SolarBloc _instance = SolarBloc._internal();

  SolarBloc._internal() : super(Initial()) {
    on<FetchSolarDataEvent>(_onSolarDataFetchHandler);
  }

  factory SolarBloc() => _instance;

  final MonitoringRepo _monitoringRepo = MonitoringRepo();

  // Handler for FetchSolarDataEvent
  Future<void> _onSolarDataFetchHandler(
      FetchSolarDataEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringDataIsLoading());
    try {
      final data = await _monitoringRepo.getMonitoringData(
        date: event.date,
        type: "solar",
      );
      int totalEnergy = 0;
      for (var number in data) {
        totalEnergy += number.value;
      }
      emit(MonitoringDataSuccessfull(data, totalEnergy));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch solar data'));
    }
  }
}
