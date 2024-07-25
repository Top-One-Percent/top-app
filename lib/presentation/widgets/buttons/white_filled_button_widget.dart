import 'package:flutter/material.dart';

class WhiteFilledButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;

  const WhiteFilledButtonWidget({super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: WidgetStateColor.resolveWith((states) => Colors.white),
        foregroundColor: WidgetStateColor.resolveWith((states) => Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      child: Text(buttonText),
    );
  }
}
