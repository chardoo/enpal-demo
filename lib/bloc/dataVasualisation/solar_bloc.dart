import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';

/// `SolarBloc` is a singleton that extends `MonitoringBloc`
/// and handles solar-related data visualization logic.
class SolarBloc extends MonitoringBloc {
  // Private constructor to prevent external instantiation.
  SolarBloc._internal({
    required super.monitoringRepo,
    required super.unitPreferenceCubit,
  });

  /// Singleton instance of `SolarBloc`.
  static SolarBloc? _instance;

  /// Factory constructor that returns the singleton instance of `SolarBloc`.
  factory SolarBloc(
          {required MonitoringRepository monitoringRepo,
          required UnitPreferenceCubit unitPreferenceCubit}) =>
      _instance ??= SolarBloc._internal(
          monitoringRepo: monitoringRepo,
          unitPreferenceCubit: unitPreferenceCubit);
          
}
