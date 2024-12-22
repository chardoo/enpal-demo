import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:enpal/bloc/dataVasualisation/battery_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/house_bloc.dart';
import 'package:enpal/bloc/dataVasualisation/monitoring/monitoring_event.dart';
import 'package:enpal/bloc/dataVasualisation/solar_bloc.dart';
import 'package:enpal/core/theme/theme_bloc.dart';
import 'package:enpal/core/theme/theme_event.dart';
import 'package:enpal/presentation/constants/widget_constants.dart';
import 'package:enpal/presentation/screens/home/tabs/battery_tab.dart';
import 'package:enpal/presentation/screens/home/tabs/house_tab.dart';
import 'package:enpal/presentation/screens/home/tabs/solar_tab.dart';
import 'package:enpal/presentation/widget/common/date_filter.dart';
import 'package:enpal/presentation/widget/common/select_unit.dart';
import 'package:enpal/utils/dateutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
              child: const Text(WidgetConstants.themeText),
            )
          ])
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final currentDate = todayDateFormat();
            _handleDateSelected(context, currentDate);
          },
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh always works
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectUnitWidget(
                        items: WidgetConstants.energyUnits,
                        onUnitSelect: (unit) =>
                            _handleUnitSelect(context, unit),
                      ),
                      DateFilter(
                          onDateSelected: (date) =>
                              _handleDateSelected(context, date)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      140, // Adjust height dynamically
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

  void _handleDateSelected(BuildContext context, String selectedDate) {
    try {
      context.read<BatteryBloc>().add(FetchMonitoringDataEvent(
            type: 'battery',
            date: selectedDate,
          ));
      context.read<SolarBloc>().add(FetchMonitoringDataEvent(
            type: 'solar',
            date: selectedDate,
          ));
      context.read<HouseBloc>().add(FetchMonitoringDataEvent(
            type: 'house',
            date: selectedDate,
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(WidgetConstants.fetchErrorMessage)),
      );
    }
  }

  void _handleUnitSelect(BuildContext context, String? selectedUnit) {
    if (selectedUnit != null) {
      context
          .read<UnitPreferenceCubit>()
          .toggleUnit(); // Assuming this toggles the unit
    }
  }
}
