import 'package:equatable/equatable.dart';

sealed class MonitoringEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchMonitoringDataEvent extends MonitoringEvent {
  final String date;
  final String type;
  FetchMonitoringDataEvent({
    required this.date,
    required this.type
  });

  @override
  List<Object?> get props => super.props;
}

class MonitoringDataPollEvent extends MonitoringEvent {
  MonitoringDataPollEvent();

  @override
  List<Object?> get props => super.props;
}
