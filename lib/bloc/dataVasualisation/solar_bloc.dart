
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';

class SolarBloc extends MonitoringBloc {
  SolarBloc._internal();
  static final SolarBloc _instance = SolarBloc._internal();
  factory SolarBloc() => _instance;
}
