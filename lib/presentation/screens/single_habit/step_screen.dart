import 'package:flutter/material.dart';
import 'package:top/config/theme/app_colors.dart';
import 'package:top/presentation/widgets/widgets.dart';

class StepScreen extends StatefulWidget {
  final List<String> steps;
  final Color habitColor;
  final VoidCallback onStepsFinished;

  StepScreen({
    super.key,
    required this.steps,
    required this.habitColor,
    required this.onStepsFinished,
  });

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  int currentStep = 0;

  void _updateCurrentStep() {
    setState(() {
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15.0),
      itemCount: widget.steps.length,
      itemBuilder: (context, index) {
        return StepCardWidget(
          stepName: widget.steps[index],
          index: index,
          currentStep: currentStep,
          color: widget.habitColor,
          onTap: _updateCurrentStep,
        );
      },
    );
  }
}
