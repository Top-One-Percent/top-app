import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircularButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.0, // Button width
      height: 60.0, // Button height
      child: IconButton.filled(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 35.0, // Icon size
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
