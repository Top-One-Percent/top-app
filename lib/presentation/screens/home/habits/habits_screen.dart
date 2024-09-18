import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top/config/router/app_router.dart';
import 'package:top/domain/models/habit.dart';
import 'package:top/presentation/screens/blocs/blocs.dart';
import 'package:top/presentation/screens/home/habits/habit_list_tile.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  bool isFiltered = true;
  bool? isRestarted;

  bool doToday(Habit habit) {
    final days = List<int>.from(habit.frequency);
    final today = DateTime.now().weekday - 1;
    if (days.contains(today)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    final habitsBloc = context.read<HabitsBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      habitsBloc.add(ResetHabits(habits: habitsBloc.state.habits));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isFiltered ? 'Today\'s Habits' : 'All Habits'),
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
                isFiltered ? Icons.today_outlined : Icons.list_alt_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state.habits.isEmpty) {
            return const Center(
              child: Text(
                'No habits yet',
                style: TextStyle(fontSize: 22.0),
              ),
            );
          } else if (!state.habitsRestarted) {
            return const Center(
                child: Text(
              'Loading...',
              style: TextStyle(fontSize: 22.0),
            ));
          } else {
            //? FILTER HABITS LIST
            final habits = isFiltered ? state.habits.where(doToday).toList() : state.habits;
            Random random = Random();
            print('Now the screen is being built');
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
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
                    child: FadeInDown(
                      from: 50,
                      duration: Duration(milliseconds: 300 + random.nextInt(301)),
                      child: HabitListTile(
                        habitId: habit.id,
                      ),
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
