import 'package:flutter/material.dart';
import 'package:top/presentation/widgets/cards/step_card_widget.dart';

import '../../../config/theme/app_colors.dart';

enum PVSC { equal, better, worse }

class StatsCardWidget extends StatelessWidget {
  final IconData icon;
  final String name;
  final String data;
  final double current;
  final double previous;

  const StatsCardWidget({
    super.key,
    required this.icon,
    required this.name,
    required this.data,
    required this.current,
    required this.previous,
  });

  @override
  Widget build(BuildContext context) {
    final pvsc = current > previous
        ? PVSC.better
        : current < previous
            ? PVSC.worse
            : PVSC.equal;

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
                          fontSize: 20.0, fontWeight: FontWeight.bold))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                pvsc == PVSC.better
                    ? Icons.arrow_upward
                    : pvsc == PVSC.worse
                        ? Icons.arrow_downward
                        : Icons.sync_alt,
                color: pvsc == PVSC.better
                    ? Colors.green
                    : pvsc == PVSC.worse
                        ? Colors.red
                        : Colors.blue,
              ),
              const SizedBox(width: 10.0),
              Text(data, style: const TextStyle(fontSize: 18.0)),
            ],
          ),
        ],
      ),
    );
  }
}
