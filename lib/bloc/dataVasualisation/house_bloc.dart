import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_bloc.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';

/// `HouseBloc` is a singleton that extends `MonitoringBloc`
/// and handles house-related data visualization logic.
class HouseBloc extends MonitoringBloc {
  // Private constructor to prevent external instantiation.
  HouseBloc._internal({
    required super.monitoringRepo,
    required super.unitPreferenceCubit,
  });

  /// Singleton instance of `HouseBloc`.
  static HouseBloc? _instance;

  /// Factory constructor that returns the singleton instance of `HouseBloc`.
  factory HouseBloc({
    required MonitoringRepository monitoringRepo,
    required UnitPreferenceCubit unitPreferenceCubit,
  }) {
    // Initialize the singleton if it hasn't been already.
    _instance ??= HouseBloc._internal(
      monitoringRepo: monitoringRepo,
      unitPreferenceCubit: unitPreferenceCubit,
    );

    return _instance!;
  }
}
