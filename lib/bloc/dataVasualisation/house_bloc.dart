import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';

/// `HouseBloc` is a singleton that extends `MonitoringBloc`
/// and handles house-related data visualization logic.
class HouseBloc extends MonitoringBloc {
  // Private constructor to prevent external instantiation.
  HouseBloc._internal();

  /// Singleton instance of `HouseBloc`.
  static final HouseBloc _instance = HouseBloc._internal();

  /// Factory constructor that returns the singleton instance of `HouseBloc`.
  factory HouseBloc() => _instance;
}
