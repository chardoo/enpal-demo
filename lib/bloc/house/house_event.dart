import 'package:equatable/equatable.dart';

 sealed class HouseEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchHouseDataEvent extends HouseEvent {
  final String date;
  FetchHouseDataEvent({required this.date,});

  @override
  List<Object?> get props => super.props;
}

