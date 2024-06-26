import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/habits/habit_list_tile.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state.habits.isEmpty) {
            return const Center(
              child: Text(
                'No habits yet',
                style: TextStyle(fontSize: 22.0),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView.builder(
                itemCount: state.habits.length,
                itemBuilder: (context, index) {
                  final habit = state.habits[index];
                  return Dismissible(
                    key: ValueKey(habit.id),
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
                    child: HabitListTile(
                      habitIndex: index,
                    ),
                    onDismissed: (direction) {
                      context.read<HabitsBloc>().add(RemoveHabit(habitId: habit.id));
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appRouter.push('/newHabit');
        },
        backgroundColor: Colors.white, // White button
        foregroundColor: Colors.black,
        child: const Icon(Icons.add), // Black icon
      ),
    );
  }
}
