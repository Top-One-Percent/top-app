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

  void _updateCurrentStep() async {
    setState(() {
      currentStep++;
    });
    if (currentStep >= widget.steps.length) {
      await Future.delayed(const Duration(milliseconds: 600));
      widget.onStepsFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 30.0),
            const Text('Follow the steps', style: TextStyle(fontSize: 24.0)),
            const SizedBox(height: 30.0),
            Expanded(
              child: ListView.builder(
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
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: widget.onStepsFinished,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: AppColors.grey,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: AppColors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
