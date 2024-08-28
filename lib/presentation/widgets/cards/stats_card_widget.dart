import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';

class StatsCardWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  final String data;

  const StatsCardWidget(
      {super.key, required this.icon, required this.name, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.almostBlack,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50.0),
              const SizedBox(width: 15.0),
              Flexible(
                  child: Text(name,
                      style: const TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold))),
            ],
          ),
          Text(data, style: const TextStyle(fontSize: 20.0)),
        ],
      ),
    );
  }
}
