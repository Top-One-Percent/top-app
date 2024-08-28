import 'package:flutter/material.dart';

class IconSelectorWidget extends StatefulWidget {
  final String? initialIcon;
  final ValueChanged<String> onIconSelected;

  const IconSelectorWidget(
      {super.key, required this.onIconSelected, this.initialIcon});

  @override
  State<IconSelectorWidget> createState() => _IconSelectorWidgetState();
}

class _IconSelectorWidgetState extends State<IconSelectorWidget> {
  IconData _selectedIcon = Icons.access_time;

  @override
  void initState() {
    _selectedIcon = widget.initialIcon != null
        ? IconData(int.parse(widget.initialIcon!), fontFamily: 'MaterialIcons')
        : Icons.access_time;
    super.initState();
  }

  void _showIconPickerBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[850],
      context: context,
      builder: (context) {
        return Container(
          height: 300,
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
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey[850])),
            color: Colors.white,
            padding: const EdgeInsets.all(0),
            iconSize: 30.0,
            icon: Icon(_selectedIcon),
            onPressed: _showIconPickerBottomSheet,
          ),
        ],
      ),
    );
  }
}

const List<IconData> icons = [
  Icons.access_time,
  Icons.account_balance_wallet,
  Icons.ad_units_rounded,
  Icons.work_outlined,
  Icons.computer_outlined,
  Icons.chrome_reader_mode_outlined,
  Icons.book,
  Icons.camera_alt_outlined,
  Icons.water_drop_outlined,
  Icons.bed,
  Icons.clean_hands,
  Icons.run_circle_outlined,
  Icons.sports_basketball,
  Icons.water,
  Icons.school,
  Icons.ac_unit_outlined,
  Icons.accessibility_new_outlined,
  Icons.apartment_outlined,
  Icons.article,
  Icons.attach_email_rounded,
  Icons.attach_money_outlined,
  Icons.bathroom_outlined,
  Icons.build_rounded,
  Icons.business_center_sharp,
  Icons.calculate_rounded,
  Icons.calendar_month_sharp,
  Icons.call_sharp,
  Icons.candlestick_chart,
  Icons.chat_sharp,
  Icons.check_box,
  Icons.checklist_sharp,
  Icons.cleaning_services_rounded,
  Icons.code,
  Icons.coffee_sharp,
  Icons.color_lens_outlined,
  Icons.currency_bitcoin,
  Icons.description,
  Icons.desktop_mac_outlined,
  Icons.diamond,
  Icons.dining_outlined,
  Icons.directions_bike_outlined,
  Icons.directions_run,
];
