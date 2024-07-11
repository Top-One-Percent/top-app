import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/domain/models/models.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/goals/goal_card.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  bool isFiltered = true;

  bool isAchieved(Goal goal) {
    if (goal.logs.isNotEmpty && goal.logs.last.currentValue >= goal.target) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isFiltered ? 'Active Goals' : 'Achieved Goals'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFiltered = !isFiltered;
              });
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                isFiltered ? Icons.check_box_outline_blank_outlined : Icons.check_box_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<GoalBloc, GoalState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.goals.isEmpty) {
            return const Center(
              child: Text(
                'No goals yet',
                style: TextStyle(fontSize: 22.0),
              ),
            );
          } else {
            final goals = isFiltered
                ? state.goals
                    .where(
                      (goal) => !isAchieved(goal),
                    )
                    .toList()
                : state.goals
                    .where(
                      (goal) => isAchieved(goal),
                    )
                    .toList();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  Random random = Random();
                  final goal = goals[index];
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
                        size: 35.0,
                      ),
                    ),
                    child: FadeInDown(
                      from: 50,
                      duration: Duration(milliseconds: 300 + random.nextInt(301)),
                      child: GoalCard(
                        goal: goal,
                        index: index,
                      ),
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
