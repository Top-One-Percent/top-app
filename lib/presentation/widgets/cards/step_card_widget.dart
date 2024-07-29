import 'package:flutter/material.dart';

enum ST { prev, curr, next } // ST: Step Type

class StepCardWidget extends StatelessWidget {
  final String stepName;
  final int index, currentStep;
  final Color color;
  final VoidCallback? onTap;

  const StepCardWidget(
      {super.key,
      required this.stepName,
      required this.index,
      required this.currentStep,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    ST type = sT(index: index, current: currentStep);

    return GestureDetector(
      onTap: type == ST.curr ? onTap : null,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 30.0),
        elevation: 8,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: type == ST.curr
                ? LinearGradient(
                    colors: [color.withOpacity(0.6), color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 30.0),
          child: type == ST.prev
              ? Icon(
                  Icons.check,
                  color: color,
                  size: 30.0,
                )
              : Text(
                  stepName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                ),
        ),
      ),
    );
  }

  ST sT({required int index, required int current}) {
    if (current < index) {
      return ST.next;
    } else if (current > index) {
      return ST.prev;
    } else {
      return ST.curr;
    }
  }
}
