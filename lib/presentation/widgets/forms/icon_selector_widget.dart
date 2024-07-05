import 'package:flutter/material.dart';

class IconSelectorWidget extends StatefulWidget {
  final String? initialIcon;
  final ValueChanged<String> onIconSelected;

  const IconSelectorWidget({super.key, required this.onIconSelected, this.initialIcon});

  @override
  State<IconSelectorWidget> createState() => _IconSelectorWidgetState();
}

class _IconSelectorWidgetState extends State<IconSelectorWidget> {
  IconData _selectedIcon = Icons.access_time;

  void _showIconPickerBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[850],
      context: context,
      builder: (context) {
        return Container(
          height: 300, // Define a fixed height to avoid intrinsic sizing issues
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: icons.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIcon = icons[index];
                    widget.onIconSelected(_selectedIcon.codePoint.toString());
                  });
                  Navigator.of(context).pop();
                },
                child: Icon(
                  icons[index],
                  size: 30.0,
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
            'Select an icon:',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(width: 10.0),
          IconButton.filled(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey[850])),
            color: Colors.white,
            padding: const EdgeInsets.all(0),
            iconSize: 30.0,
            icon: Icon(widget.initialIcon != null
                ? IconData(int.parse(widget.initialIcon!), fontFamily: 'MaterialIcons')
                : _selectedIcon),
            onPressed: _showIconPickerBottomSheet,
          ),
        ],
      ),
    );
  }
}

const List<IconData> icons = [
  Icons.access_time,
  Icons.account_circle,
  Icons.add_shopping_cart,
  Icons.airplane_ticket,
];
