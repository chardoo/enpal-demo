import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';

/// `BatteryBloc` is a singleton that extends `MonitoringBloc`
/// and handles battery-related data visualization logic.
class BatteryBloc extends MonitoringBloc {
  // Private constructor to prevent external instantiation.
  BatteryBloc._internal();

  /// Singleton instance of `BatteryBloc`.
  static final BatteryBloc _instance = BatteryBloc._internal();

  /// Factory constructor that returns the singleton instance of `BatteryBloc`.
  factory BatteryBloc() => _instance;

  
}
