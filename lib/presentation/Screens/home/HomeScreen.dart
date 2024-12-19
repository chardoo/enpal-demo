import 'package:enpal/bloc/battery/monitoring_bloc.dart';
import 'package:enpal/bloc/battery/monitoring_event.dart';
import 'package:enpal/bloc/bloc_wrapper.dart';
import 'package:enpal/bloc/house/house_bloc.dart';
import 'package:enpal/bloc/house/house_event.dart';
import 'package:enpal/bloc/solar/solar_bloc.dart';
import 'package:enpal/bloc/solar/solar_event.dart';
import 'package:enpal/presentation/Screens/home/tabs/BatteryTab.dart';
import 'package:enpal/presentation/Screens/home/tabs/HouseTab.dart';
import 'package:enpal/presentation/Screens/home/tabs/SolarTab.dart';
import 'package:enpal/presentation/widget/DateFilter.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final currentDate = DateTime.now().toString().substring(0, 10);
            _handleDateSelected(currentDate);
          },
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh always works
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: DateFilter(onDateSelected: _handleDateSelected),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      100, // Adjust height dynamically
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            children: [
                              SolarTabScreen(),
                              HouseTabScreen(),
                              BatteryTabScreen(),
                            ],
                          ),
                        ),
                        const TabBar(
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(icon: Icon(Icons.solar_power)),
                            Tab(icon: Icon(Icons.house)),
                            Tab(icon: Icon(Icons.battery_0_bar)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDateSelected(String selectedDate) {
   MyBlocWrapper.batteryInstance.add(FetchMonitoringDataEvent(
    type: 'battery',
      date: selectedDate,
    ));

     MyBlocWrapper.batteryInstance.add(FetchMonitoringDataEvent(
    type: 'solar',
      date: selectedDate,
    ));
     MyBlocWrapper.batteryInstance.add(FetchMonitoringDataEvent(
    type: 'house',
      date: selectedDate,
    ));
   
  }
}
