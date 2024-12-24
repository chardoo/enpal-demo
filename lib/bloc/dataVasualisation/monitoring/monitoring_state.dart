import 'package:enpal/data/models/monitoring_data.dart';
import 'package:equatable/equatable.dart';

// Base class for all states
sealed class MonitoringState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class Initial extends MonitoringState {}

// Loading state
class MonitoringDataIsLoading extends MonitoringState {}

// Failure state with error message
class MonitoringDataFailed extends MonitoringState {
  final String message;

  MonitoringDataFailed(this.message);

  @override
  List<Object?> get props => [message];
}

// Success state with data and total energy
class DataSuccessful extends MonitoringState {
  final List<MonitoringData> data;
  final double totalEnergy;
  final String unit;
  DataSuccessful(this.data, this.totalEnergy, this.unit);

  @override
  List<Object?> get props => [data, totalEnergy];
}
