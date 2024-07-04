import 'package:flutter/material.dart';

class StepScreen extends StatefulWidget {
  final List<String> steps;
  final Color habitColor;
  final VoidCallback onStepsFinished;

  const StepScreen({
    Key? key,
    required this.steps,
    required this.habitColor,
    required this.onStepsFinished,
  }) : super(key: key);

  @override
  _StepScreenState createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (currentStep < widget.steps.length - 1) {
          setState(() {
            currentStep++;
          });
        } else {
          widget.onStepsFinished();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: widget.habitColor.withOpacity((currentStep + 1) / widget.steps.length),
        child: Center(
          child: Text(
            widget.steps[currentStep],
            style: const TextStyle(fontSize: 26, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
