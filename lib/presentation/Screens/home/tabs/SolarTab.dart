
import 'package:enpal/bloc/battery/monitoring_bloc.dart';
import 'package:enpal/bloc/bloc_wrapper.dart';
import 'package:enpal/bloc/monitoring_state.dart';
import 'package:enpal/bloc/solar/solar_bloc.dart';
import 'package:enpal/presentation/widget/GraphWiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolarTabScreen extends StatelessWidget {
  const SolarTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitoringBloc, MonitoringState>(
       bloc: MyBlocWrapper.solarInstance,
      builder: (context, state) {
        if (state is MonitoringDataIsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MonitoringDataSuccessfull) {
          return GrapheWidget(data: state.data, totalEnergy: state.totalEnergy, eneryType: 'Solar',);
        } else if (state is MonitoringDataFailed) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('No data available.'));
      },
    );
  }
}