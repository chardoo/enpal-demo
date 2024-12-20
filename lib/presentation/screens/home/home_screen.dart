
import 'package:enpal/bloc/dataVasualisation/battery_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/house_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/solar_bloc.dart';
import 'package:enpal/bloc/theme/theme_bloc.dart';
import 'package:enpal/bloc/theme/theme_event.dart';
import 'package:enpal/presentation/screens/home/tabs/battery_tab.dart';
import 'package:enpal/presentation/screens/home/tabs/house_tab.dart';
import 'package:enpal/presentation/screens/home/tabs/solar_tab.dart';
import 'package:enpal/presentation/widget/common/date_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
          child: const Text('Change Theme'),
        ))),
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
   BatteryBloc().add(FetchMonitoringDataEvent(
    type: 'battery',
      date: selectedDate,
    ));
     SolarBloc().add(FetchMonitoringDataEvent(
    type: 'solar',
      date: selectedDate,
    ));
     HouseBloc().add(FetchMonitoringDataEvent(
    type: 'house',
      date: selectedDate,
    ));
   
  }
}
