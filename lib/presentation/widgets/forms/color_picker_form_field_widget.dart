import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';

class ColorPickerFormFieldWidget extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerFormFieldWidget({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Color>(
      value: selectedColor,
      decoration: InputDecoration(
        labelText: 'Select Color',
        labelStyle: const TextStyle(color: AppColors.grey),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      ),
      dropdownColor: Colors.grey[850],
      iconEnabledColor: AppColors.grey,
      items: AppColors.colorOptions.map((Color color) {
        return DropdownMenuItem<Color>(
          value: color,
          child: Container(
            width: 24,
            height: 24,
            color: color,
          ),
        );
      }).toList(),
      onChanged: (Color? newColor) {
        if (newColor != null) {
          onColorChanged(newColor);
        }
      },
    );
  }
}
