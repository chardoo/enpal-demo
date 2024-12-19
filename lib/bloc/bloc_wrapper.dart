import 'package:enpal/bloc/battery/monitoring_bloc.dart';

class MyBlocWrapper {
  static final MonitoringBloc batteryInstance = MonitoringBloc();
  static final MonitoringBloc houseInstance = MonitoringBloc();
  static final MonitoringBloc solarInstance = MonitoringBloc();
}