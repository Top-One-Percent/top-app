import 'package:flutter/material.dart';

class UnitTypeSelectorWidget extends StatefulWidget {
  final ValueChanged<String> onUnitSelected;

  const UnitTypeSelectorWidget({super.key, required this.onUnitSelected});

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
          height: 250, // Adjust height based on your needs
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 3, // Aspect ratio adjusted for text
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
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
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(units[index],
                      style: const TextStyle(fontSize: 20.0, color: Colors.white)),
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
              _selectedUnit,
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
