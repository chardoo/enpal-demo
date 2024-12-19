import 'package:equatable/equatable.dart';

 sealed class SolarEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchSolarDataEvent extends SolarEvent {
  final String date;
  FetchSolarDataEvent({required this.date});

  @override
  List<Object?> get props => super.props;
}

