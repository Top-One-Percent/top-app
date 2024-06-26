import 'package:flutter/material.dart';

class HoursSelectorWidget extends StatefulWidget {
  final Function(List<TimeOfDay>) onHoursChanged;

  const HoursSelectorWidget({super.key, required this.onHoursChanged});

  @override
  State<HoursSelectorWidget> createState() => _HoursSelectorWidgetState();
}

class _HoursSelectorWidgetState extends State<HoursSelectorWidget> {
  List<TimeOfDay> selectedHours = [];

  void _addHour() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && !selectedHours.contains(picked)) {
      setState(() {
        selectedHours.add(picked);
        widget.onHoursChanged(selectedHours);
      });
    }
  }

  void _removeHour(TimeOfDay hour) {
    setState(() {
      selectedHours.remove(hour);
      widget.onHoursChanged(selectedHours);
    });
  }

  Widget _buildHourChip(TimeOfDay hour) {
    return GestureDetector(
      onTap: () => _removeHour(hour),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          hour.format(context),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: selectedHours.length <= 3
            ? 50
            : 100, // Adjust height based on the number of lines roughly.
        child: Row(
          children: [
            InkWell(
              onTap: _addHour,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Wrap(
                children: selectedHours.map((hour) => _buildHourChip(hour)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
