import 'package:enpal/bloc/cubit/unit_preference_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectUnitWidget extends StatelessWidget {
  const SelectUnitWidget(
      {super.key, required this.onUnitSelect, required this.items});
  final Function(String?) onUnitSelect;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitPreferenceCubit, String>(
      builder: (context, unit) {
        return DropdownButton<String>(
          value: unit,
          items: items.map((String value) {
           
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onUnitSelect,
        );
      },
    );
  }
}
