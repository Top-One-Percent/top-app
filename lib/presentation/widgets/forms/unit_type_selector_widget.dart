import 'package:flutter/material.dart';
import 'package:top/core/utils/capitalize.dart';

class UnitTypeSelectorWidget extends StatefulWidget {
  final String? initialUnit;
  final ValueChanged<String> onUnitSelected;

  const UnitTypeSelectorWidget({super.key, required this.onUnitSelected, this.initialUnit});

  @override
  State<UnitTypeSelectorWidget> createState() => _UnitTypeSelectorWidgetState();
}

class _UnitTypeSelectorWidgetState extends State<UnitTypeSelectorWidget> {
  String _selectedUnit = 'rep';

  void _showUnitPickerBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[850],
      context: context,
      builder: (context) {
        return Container(
          height: 330, // Adjust height based on your needs
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: units.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedUnit = units[index];
                    widget.onUnitSelected(_selectedUnit);
                  });
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${capitalize(units[index])}: ${units[index] == 'rep' ? 'For anything that must be counted (even if just once).' : units[index] == 'hr' ? 'For habits that take 1 hour or more' : 'For habits that take 1 minute or more'}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      leading: Icon(units[index] == 'rep' ? Icons.repeat : Icons.timer_sharp,
                          size: 35.0),
                      trailing: const Icon(Icons.circle_outlined),
                    ),
                    index < 2
                        ? const Divider(
                            indent: 10.0,
                            endIndent: 10.0,
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          const Text(
            'Select an unit type:',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: _showUnitPickerBottomSheet,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: Colors.grey[850], // Background color
              foregroundColor: Colors.white, // Text color
            ),
            child: Text(
              widget.initialUnit ?? _selectedUnit,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> units = [
  'rep',
  'hr',
  'min',
];
