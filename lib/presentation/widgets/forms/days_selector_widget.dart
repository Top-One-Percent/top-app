import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';

class DaysSelectorWidget extends StatefulWidget {
  final Function(List<int>) onSelectionChanged;
  final List<int>? initialSelectedDays;

  const DaysSelectorWidget({super.key, required this.onSelectionChanged, this.initialSelectedDays});

  @override
  _DaysSelectorWidgetState createState() => _DaysSelectorWidgetState();
}

class _DaysSelectorWidgetState extends State<DaysSelectorWidget> {
  List<int> selectedDays = [];

  // List of days with their names and indices
  final List<DayOfWeek> days = [
    DayOfWeek("Monday", 0),
    DayOfWeek("Tuesday", 1),
    DayOfWeek("Wednesday", 2),
    DayOfWeek("Thursday", 3),
    DayOfWeek("Friday", 4),
    DayOfWeek("Saturday", 5),
    DayOfWeek("Sunday", 6),
  ];

  void _handleTap(int dayIndex) {
    setState(() {
      if (selectedDays.contains(dayIndex)) {
        selectedDays.remove(dayIndex);
      } else {
        selectedDays.add(dayIndex);
      }
      // Sort the list of selected days
      selectedDays.sort();
      // Call the callback function to update the parent widget
      widget.onSelectionChanged(selectedDays);
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedDays = widget.initialSelectedDays ?? selectedDays;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days.map((day) {
        bool isSelected = selectedDays.contains(day.index);
        return GestureDetector(
          onTap: () => _handleTap(day.index),
          child: CircleAvatar(
            backgroundColor: isSelected ? Colors.white : Colors.grey[850],
            child: Text(day.name.substring(0, 2),
                style: TextStyle(color: isSelected ? Colors.black : Colors.white)),
          ),
        );
      }).toList(),
    );
  }
}
