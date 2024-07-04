import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/screens.dart';

class SingleHabitScreen extends StatefulWidget {
  final int habitId;

  const SingleHabitScreen({super.key, required this.habitId});

  @override
  State<SingleHabitScreen> createState() => _SingleHabitScreenState();
}

class _SingleHabitScreenState extends State<SingleHabitScreen> {
  bool stepsCompleted = false;

  @override
  Widget build(BuildContext context) {
    final _controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HabitsBloc, HabitsState>(
          builder: (context, state) {
            final habit = state.habits[widget.habitId];

            return Text(habit.name);
          },
        ),
      ),
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          final habit = state.habits[widget.habitId];
          final steps = habit.steps;
          return Column(
            children: [
              Expanded(
                child: steps != null && steps.isNotEmpty && stepsCompleted == false
                    ? StepScreen(
                        steps: steps,
                        habitColor: Color(habit.colorValue),
                        onStepsFinished: () {
                          setState(() {
                            stepsCompleted = true;
                          });
                        },
                      )
                    : PageView(
                        controller: _controller,
                        children: [
                          HabitProgressView(habitId: widget.habitId),
                          const HabitStatsView(),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 2,
                  effect: const ExpandingDotsEffect(activeDotColor: Colors.white),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
