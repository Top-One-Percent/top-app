import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';

class IconTextCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: AppColors.darkGrey,
          title: Text(text),
          leading: Icon(icon, color: AppColors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: AppColors.middleGrey,
              width: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
