import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';

/// `BatteryBloc` extends `MonitoringBloc` to handle battery-specific data visualization.
class BatteryBloc extends MonitoringBloc {
  /// Private constructor to restrict external instantiation.
  BatteryBloc._internal({
    required super.monitoringRepo,
    required super.unitPreferenceCubit,
  });

  /// Singleton instance of `BatteryBloc`.
  static  BatteryBloc? _instance;

  /// Factory constructor that initializes and returns the singleton instance.
  factory BatteryBloc({
    required MonitoringRepository monitoringRepo,
    required UnitPreferenceCubit unitPreferenceCubit,
  })  {
    _instance ??= BatteryBloc._internal(monitoringRepo: monitoringRepo, unitPreferenceCubit: unitPreferenceCubit);
    return _instance!;
  }
}
