import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';

/// `SolarBloc` is a singleton that extends `MonitoringBloc`
/// and handles solar-related data visualization logic.
class SolarBloc extends MonitoringBloc {
  // Private constructor to prevent external instantiation.
  SolarBloc._internal();

  /// Singleton instance of `SolarBloc`.
  static final SolarBloc _instance = SolarBloc._internal();

  /// Factory constructor that returns the singleton instance of `SolarBloc`.
  factory SolarBloc() => _instance;
}
