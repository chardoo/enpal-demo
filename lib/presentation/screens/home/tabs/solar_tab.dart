
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/bloc/dataVasualisation/solar_bloc.dart';
import 'package:enpal/presentation/constants/widget_constants.dart';
import 'package:enpal/presentation/widget/common/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolarTabScreen extends StatelessWidget {
  const SolarTabScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolarBloc, MonitoringState>(
      builder: (context, state) {
        if (state is MonitoringDataIsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DataSuccessful) {
          return GraphWidget(data: state.data, totalEnergy: state.totalEnergy,units: state.unit, energyType: WidgetConstants.solarTabTitle,);
        } else if (state is MonitoringDataFailed) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text(WidgetConstants.noDataMessage));
      },
    );
  }
}