import 'package:enpal/utils/dateutils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DateFilter extends StatefulWidget {
  final Function(String) onDateSelected;
  final String selectedDate; // Add selectedDate parameter

  const DateFilter({
    super.key,
    required this.onDateSelected,
    required this.selectedDate,
  });

  @override
  DateFilterState createState() => DateFilterState();
}

class DateFilterState extends State<DateFilter> {
  late String _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate; // Initialize with the passed value
  }

  @override
  void didUpdateWidget(covariant DateFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      setState(() {
        _selectedDate = widget.selectedDate;
      });
    }
  }

  Future<void> _pickDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_selectedDate),
      firstDate: DateTime.now().subtract(const Duration(days: 10000)),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            final previousDate =
                DateTime.parse(_selectedDate).subtract(const Duration(days: 1));
            setState(() {
              _selectedDate = DateFormat('yyyy-MM-dd').format(previousDate);
            });
            widget.onDateSelected(_selectedDate);
          },
        ),
        GestureDetector(
          onTap: _pickDate,
          child: Text(
            _selectedDate,
            style: const TextStyle(fontSize: 19),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          onPressed: todayDateFormat() == _selectedDate
              ? null
              : () {
                  final nextDate = DateTime.parse(_selectedDate)
                      .add(const Duration(days: 1));
                  setState(() {
                    _selectedDate = DateFormat('yyyy-MM-dd').format(nextDate);
                  });
                  widget.onDateSelected(_selectedDate);
                },
        ),
      ],
    );
  }
}
