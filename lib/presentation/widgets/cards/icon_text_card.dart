import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';

class IconTextCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  const IconTextCard(
      {super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ListTile(
            tileColor: AppColors.darkGrey,
            title: Text(
              text,
              style: const TextStyle(fontSize: 18.0),
            ),
            leading: Icon(icon, color: AppColors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: AppColors.middleGrey,
                width: 1.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
