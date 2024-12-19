import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enpal/bloc/house/house_event.dart';
import 'package:enpal/bloc/monitoring_state.dart';
import 'package:enpal/data/repository/monitoring_repo.dart';

class HouseBloc extends Bloc<HouseEvent, MonitoringState> {
  // Singleton instance
  static final HouseBloc _instance = HouseBloc._internal();
  
  HouseBloc._internal() : super(Initial()) {
    on<FetchHouseDataEvent>(_onHouseDataFetchHandler);
  }
  factory HouseBloc() => _instance;
  final MonitoringRepo _monitoringRepo = MonitoringRepo();

  // Handler for FetchHouseDataEvent
  Future<void> _onHouseDataFetchHandler(
      FetchHouseDataEvent event, Emitter<MonitoringState> emit) async {
    emit(MonitoringDataIsLoading());
    try {
      final data = await _monitoringRepo.getMonitoringData(
        date: event.date,
        type:  "house",
      );
      int totalEnergy = 0;
      for (var number in data) {
        totalEnergy += number.value;
      }
      emit(MonitoringDataSuccessfull(data, totalEnergy));
    } catch (e) {
      emit(MonitoringDataFailed('Failed to fetch house data'));
    }
  }
}
