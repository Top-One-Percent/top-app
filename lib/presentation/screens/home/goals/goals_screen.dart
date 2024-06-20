import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/goals/goal_card.dart';
import 'package:top/presentation/widgets/widgets.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        centerTitle: false,
      ),
      body: BlocBuilder<GoalBloc, GoalState>(
        builder: (context, state) {
          if (state.goals.isEmpty) {
            return const Center(
              child: Text(
                'No goals yet',
                style: TextStyle(fontSize: 22.0),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView.builder(
                itemCount: state.goals.length,
                itemBuilder: (context, index) {
                  final goal = state.goals[index];
                  return Dismissible(
                    key: ValueKey(goal),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      padding: const EdgeInsets.all(15.0),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                    child: GoalCard(
                      goal: goal,
                      index: index,
                    ),
                    onDismissed: (direction) {
                      context.read<GoalBloc>().add(RemoveGoal(index));
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appRouter.push('/newGoal');
        },
        backgroundColor: Colors.white, // White button
        foregroundColor: Colors.black,
        child: const Icon(Icons.add), // Black icon
      ),
    );
  }
}
