import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/battery_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/house_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/solar_bloc.dart';
import 'package:enpal/data/repository/impl/monitoring_repo.dart';
import 'package:enpal/data/storage/cache.dart';
import 'package:enpal/utils/dateutils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

MultiBlocProvider initCoreBlocs(Widget view) {
   final AppDatabase db = AppDatabase();
  return MultiBlocProvider(
    providers: [
     
        BlocProvider(
        create: (context) => SolarBloc(monitoringRepo:  MonitoringRepository(db: db), unitPreferenceCubit: UnitPreferenceCubit())
          ..add(FetchMonitoringDataEvent(
            type: 'solar',
              date:
                  todayDateFormat(),
            )),
      ),
       BlocProvider(
        create: (context) => HouseBloc(monitoringRepo:  MonitoringRepository(db: db), unitPreferenceCubit: UnitPreferenceCubit())
          ..add(FetchMonitoringDataEvent(
            type: 'house',
              date:
                  todayDateFormat(),
            )),
      ),
     
      BlocProvider(
        create: (context) => BatteryBloc(monitoringRepo: MonitoringRepository(db: db), unitPreferenceCubit: UnitPreferenceCubit())
          ..add(FetchMonitoringDataEvent(
            type: 'battery',
              date:
                  todayDateFormat(),
            )),
      ),

      
      BlocProvider(create: (context)=> UnitPreferenceCubit())
    ],
    child:view
  );

  }