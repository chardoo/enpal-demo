import 'package:equatable/equatable.dart';

sealed class MonitoringEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMonitoringDataEvent extends MonitoringEvent {
  final String date;
  final String type;
  FetchMonitoringDataEvent({required this.date, required this.type});
}

class MonitoringDataPollEvent extends MonitoringEvent {
  final String type;
  MonitoringDataPollEvent(this.type);
}
