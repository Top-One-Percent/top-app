import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/single_goal/goal_stats_view.dart';
import 'goal_progress_view.dart'; // Import the new file

class SingleGoalScreen extends StatelessWidget {
  final int goalId;

  const SingleGoalScreen({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    final _controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            final goal = state.goals[goalId];
            return Text(goal.name);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                appRouter.push('/editGoal/$goalId');
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
                GoalProgressView(goalId: goalId),
                GoalStatsView(goalId: goalId), // Placeholder for the second page
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
