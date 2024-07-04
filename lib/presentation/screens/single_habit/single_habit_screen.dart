import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/screens.dart';

class SingleHabitScreen extends StatelessWidget {
  final int habitId;

  const SingleHabitScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    final _controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HabitsBloc, HabitsState>(
          builder: (context, state) {
            final habit = state.habits[habitId];

            return Text(habit.name);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                appRouter.push('/editGoal/$habitId');
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                HabitProgressView(habitId: habitId),
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
      ),
    );
  }
}
