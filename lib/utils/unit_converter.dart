import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_state.dart';
import 'package:enpal/data/models/monitoring_data.dart';

class UnitConverter {
   DataSuccessful transformValueAndGetTotal(
      List<MonitoringData> data) {
    List<MonitoringData> graphData;
    final unit = UnitPreferenceCubit().state;
    if (unit == "kw") {
      graphData = data
          .map((element) => MonitoringData(
              value: (element.value / 1000), timestamp: element.timestamp))
          .toList();
    } else {
      graphData = data;
    }
    double totalEnergy = graphData.fold(0, (sum, item) => sum + item.value);
    final success = DataSuccessful(graphData, totalEnergy, unit);
    return success;
  }
}