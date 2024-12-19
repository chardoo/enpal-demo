import 'package:enpal/bloc/battery/monitoring_event.dart';
import 'package:enpal/bloc/bloc_wrapper.dart';
import 'package:enpal/presentation/Screens/home/HomeScreen.dart';
import 'package:enpal/utils/datautils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(home: MainScreen()));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
          BlocProvider(
          create: (context) => MyBlocWrapper.solarInstance
            ..add(FetchMonitoringDataEvent(
              type: 'solar',
                date:
                    todayDateFormat(),
              )),
        ),
        
         BlocProvider(
          create: (context) => MyBlocWrapper.houseInstance
            ..add(FetchMonitoringDataEvent(
              type: 'house',
                date:
                    todayDateFormat(),
              )),
        ),

        BlocProvider(
          create: (context) => MyBlocWrapper.batteryInstance
            ..add(FetchMonitoringDataEvent(
              type: 'battery',
                date:
                    todayDateFormat(),
              )),
        ),
      ],
      child:Homescreen()
    );
  }
}
