

import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';

class HouseBloc extends MonitoringBloc {
  HouseBloc._internal();
  static final HouseBloc _instance = HouseBloc._internal();
  factory HouseBloc() => _instance;
}
