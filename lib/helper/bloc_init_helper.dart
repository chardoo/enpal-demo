import 'package:enpal/bloc/dataVasualisation/battery_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/house_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/solar_bloc.dart';
import 'package:enpal/utils/dateutils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

MultiBlocProvider initCoreBlocs(Widget view) {
  return MultiBlocProvider(
    providers: [
     
        BlocProvider(
        create: (context) => SolarBloc()
          ..add(FetchMonitoringDataEvent(
            type: 'solar',
              date:
                  todayDateFormat(),
            )),
      ),
       BlocProvider(
        create: (context) => HouseBloc()
          ..add(FetchMonitoringDataEvent(
            type: 'house',
              date:
                  todayDateFormat(),
            )),
      ),

      BlocProvider(
        create: (context) => BatteryBloc()
          ..add(FetchMonitoringDataEvent(
            type: 'battery',
              date:
                  todayDateFormat(),
            )),
      ),
    ],
    child:view
  );

  }