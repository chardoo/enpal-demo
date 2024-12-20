
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';

class BatteryBloc extends MonitoringBloc {
  // Private constructor
  BatteryBloc._internal();

  // Singleton instance
  static final BatteryBloc _instance = BatteryBloc._internal();

  // Factory constructor to return the singleton instance
  factory BatteryBloc() => _instance;
}