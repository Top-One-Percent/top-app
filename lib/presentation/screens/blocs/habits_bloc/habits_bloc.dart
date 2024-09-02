import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top/domain/models/habit.dart';
import 'package:top/presentation/screens/single_habit/background_timer.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final Box<Habit> habitsBox;

  HabitsBloc(this.habitsBox) : super(HabitsState(habits: const [])) {
    on<LoadHabits>(_loadHabits);
    on<AddHabit>(_addHabit);
    on<EditHabit>(_editHabit);
    on<UpdateHabit>(_updateHabit);
    on<RemoveHabit>(_removeHabit);
    on<ResetHabits>(_resetHabits);
    on<UpdateHabitStats>(_updateHabitStats);
  }

  void _loadHabits(LoadHabits event, Emitter<HabitsState> emit) {
    final habits = habitsBox.values.toList();
    emit(state.copyWith(habits: habits));
  }

  void _resetHabits(ResetHabits event, Emitter<HabitsState> emit) async {
    emit(state.copyWith(habitsRestarted: false));
    print('Init reset, status: ${state.habitsRestarted}');

    final habits = event.habits;

    final habitsBox = await Hive.openBox<Habit>('habitsBox');

    if (habits.isNotEmpty) {
      for (Habit habit in habits) {
        DateTime now = DateTime.now();
        DateTime yesterday = now.subtract(const Duration(days: 1));

        if (habit.dailyHabitLogs.isEmpty ||
            habit.dailyHabitLogs.last.date.day != DateTime.now().day) {
          final lastLog = habit.habitLogs.isNotEmpty &&
                  habit.habitLogs.last.date.day == DateTime.now().day
              ? habit.habitLogs.last.complianceRate
              : 0.0;

          bool hasYesterdayLog = habit.dailyHabitLogs.any(
            (log) =>
                log.date.year == yesterday.year &&
                log.date.month == yesterday.month &&
                log.date.day == yesterday.day,
          );

          if (!hasYesterdayLog && habit.habitLogs.isNotEmpty) {
            if (habit.habitLogs.last.date.day != now.day) {
              habit.dailyHabitLogs.add(HabitLog(
                  date: now.subtract(const Duration(hours: 24)),
                  complianceRate: lastLog));
            }
          } else {
            habit.dailyHabitLogs
                .add(HabitLog(date: DateTime.now(), complianceRate: lastLog));
          }

          habit.habitLogs
              .add(HabitLog(complianceRate: 0, date: DateTime.now()));

          add(UpdateHabitStats(habitId: habit.id));
        }
      }

      await habitsBox.clear();

      for (Habit habit in habits) {
        await habitsBox.add(habit);
      }
    }

    // Reset Background Timer
    await BackgroundTimer.resetTimer();

    emit(state.copyWith(habitsRestarted: true));
    print('Finish reset, status: ${state.habitsRestarted}');
  }

  void _addHabit(AddHabit event, Emitter<HabitsState> emit) {
    final newHabit = Habit(
      name: event.name,
      frequency: event.frequency,
      color: event.color,
      icon: event.icon,
      unitType: event.unitType,
      target: event.target,
      steps: event.steps ?? [],
      remidersTime: event.remindersTime ?? [],
      linkedGoalId: event.linkedGoalId ?? '',
    );

    habitsBox.add(newHabit);

    final updatedHabits = List<Habit>.from(state.habits)..add(newHabit);
    emit(state.copyWith(habits: updatedHabits));
  }

  void _editHabit(EditHabit event, Emitter<HabitsState> emit) {
    final habitIndex = List<Habit>.from(state.habits)
        .indexWhere((element) => element.id == event.habitId);

    final habit = state.habits[habitIndex];

    final habitLogs = List<HabitLog>.from(habit.habitLogs);
    final dailyHabitLogs = List<HabitLog>.from(habit.dailyHabitLogs);

    final editedHabit = Habit(
      name: event.name,
      frequency: event.frequency,
      color: event.color,
      icon: event.icon,
      unitType: event.unitType,
      habitLogs: habitLogs,
      dailyHabitLogs: dailyHabitLogs,
      target: event.target,
      remidersTime: event.remindersTime,
      steps: event.steps,
      linkedGoalId: event.linkedGoalId,
      bestStreak: habit.bestStreak,
      dailyAvg: habit.dailyAvg,
      totalDays: habit.totalDays,
      overallRate: habit.overallRate,
    );

    habitsBox.putAt(habitIndex, editedHabit);

    final updatedHabits = List<Habit>.from(state.habits);

    updatedHabits[habitIndex] = editedHabit;

    emit(state.copyWith(habits: updatedHabits));
  }

  void _updateHabit(UpdateHabit event, Emitter<HabitsState> emit) {
    final updatedHabits = List<Habit>.from(state.habits);

    final newHabitLog =
        HabitLog(date: DateTime.now(), complianceRate: event.newComplianceRate);

    final habit = updatedHabits[event.habitId];
    final updatedHabitLogs = List<HabitLog>.from(habit.habitLogs)
      ..add(newHabitLog);

    List<HabitLog> updatedDailyHabitLogs = [];
    if (habit.dailyHabitLogs.isEmpty ||
        habit.dailyHabitLogs.last.date.day != DateTime.now().day) {
      updatedDailyHabitLogs.add(newHabitLog);
    } else if (habit.dailyHabitLogs.last.date.day == DateTime.now().day) {
      updatedDailyHabitLogs = List<HabitLog>.from(habit.dailyHabitLogs)
        ..removeLast();
      updatedDailyHabitLogs.add(newHabitLog);
    }

    final updatedHabit = Habit(
      name: habit.name,
      frequency: habit.frequency,
      color: Color(habit.colorValue),
      icon: habit.icon,
      unitType: habit.unitType,
      habitLogs: updatedHabitLogs,
      dailyHabitLogs: updatedDailyHabitLogs,
      target: habit.target,
      steps: habit.steps,
      linkedGoalId: habit.linkedGoalId,
      remidersTime: habit.remidersTime,
      overallRate: habit.overallRate,
      totalDays: habit.totalDays,
      dailyAvg: habit.dailyAvg,
      bestStreak: habit.bestStreak,
    );

    habitsBox.putAt(event.habitId, updatedHabit);

    updatedHabits[event.habitId] = updatedHabit;
    emit(state.copyWith(habits: updatedHabits));

    add(UpdateHabitStats(habitId: updatedHabit.id));
  }

  void _removeHabit(RemoveHabit event, Emitter<HabitsState> emit) {
    final updatedHabits = List<Habit>.from(state.habits);
    final habitIndex =
        updatedHabits.indexWhere((element) => element.id == event.habitId);

    habitsBox.deleteAt(habitIndex);

    updatedHabits.removeAt(habitIndex);

    emit(state.copyWith(habits: updatedHabits));
  }

  void _updateHabitStats(UpdateHabitStats event, Emitter<HabitsState> emit) {
    final updatedHabits = List<Habit>.from(state.habits);
    final habitIndex =
        updatedHabits.indexWhere((habit) => habit.id == event.habitId);
    final habit = updatedHabits[habitIndex];

    // SET CONSTANTS
    final dailyLogsSize = habit.dailyHabitLogs.length;

    // CALC BEST STREAK
    final int currentBestStreak = habit.bestStreak.last;
    int streakCounter = 0;
    int totalDaysCounter = 0;
    double totalDone = 0;

    for (int i = dailyLogsSize - 1; i >= 0; i--) {
      final hCR = habit.dailyHabitLogs[i].complianceRate / habit.target;
      totalDone += hCR;
      if (hCR >= 1) {
        streakCounter++;
        totalDaysCounter++;
      }
      if (hCR < 1) {
        if (streakCounter > currentBestStreak) {
          habit.bestStreak.add(streakCounter);
          if (habit.bestStreak.length >= 3) {
            habit.bestStreak.removeAt(0);
          }
        }
        streakCounter = 0;
      }
    }
    streakCounter = streakCounter;

    habit.totalDays.add(totalDaysCounter);
    if (habit.totalDays.length >= 3) {
      habit.totalDays.removeAt(0);
    }
    habit.dailyAvg.add(totalDone / dailyLogsSize);
    if (habit.dailyAvg.length >= 3) {
      habit.dailyAvg.removeAt(0);
    }
    habit.overallRate.add(totalDaysCounter / dailyLogsSize);
    if (habit.overallRate.length >= 3) {
      habit.overallRate.removeAt(0);
    }

    print('STREAK: ${habit.bestStreak}');
    print('DAYS: ${habit.totalDays}');
    print('AVG: ${habit.dailyAvg}');
    print('OVERALL: ${habit.overallRate}');

    // Update state and Hive box
    habitsBox.putAt(habitIndex, habit);
    updatedHabits[habitIndex] = habit;

    emit(state.copyWith(habits: updatedHabits));
  }
}
