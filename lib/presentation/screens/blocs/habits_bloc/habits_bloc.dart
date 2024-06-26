import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top/domain/models/habit.dart';

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
  }

  void _loadHabits(LoadHabits event, Emitter<HabitsState> emit) {
    final habits = habitsBox.values.toList();
    emit(state.copyWith(habits: habits));
  }

  void _addHabit(AddHabit event, Emitter<HabitsState> emit) {
    final newHabit = Habit(
      name: event.name,
      frequency: event.frequency,
      color: event.color,
      icon: event.icon,
      unitType: event.unitType,
      target: event.target,
    );

    habitsBox.add(newHabit);

    final updatedHabits = List<Habit>.from(state.habits)..add(newHabit);
    emit(state.copyWith(habits: updatedHabits));
  }

  void _editHabit(EditHabit event, Emitter<HabitsState> emit) {
    final habitIndex =
        List<Habit>.from(state.habits).indexWhere((element) => element.id == event.habitId);

    final habitLogs = List<HabitLog>.from(state.habits[habitIndex].habitLogs);

    final editedHabit = Habit(
      name: event.name,
      frequency: event.frequency,
      color: event.color,
      icon: event.icon,
      unitType: event.unitType,
      habitLogs: habitLogs,
      target: event.target,
    );

    habitsBox.putAt(habitIndex, editedHabit);

    final updatedHabits = List<Habit>.from(state.habits);

    updatedHabits[habitIndex] = editedHabit;

    emit(state.copyWith(habits: updatedHabits));
  }

  void _updateHabit(UpdateHabit event, Emitter<HabitsState> emit) {
    final updatedHabits = List<Habit>.from(state.habits);
    final habitIndex = updatedHabits.indexWhere((element) => element.id == event.habitId);
    final habit = updatedHabits[habitIndex];
    final updatedHabitLogs = List<HabitLog>.from(habit.habitLogs)
      ..add(HabitLog(date: DateTime.now(), complianceRate: event.newComplianceRate));

    final updatedHabit = Habit(
      name: habit.name,
      frequency: habit.frequency,
      color: habit.colorValue as Color,
      icon: habit.icon,
      unitType: habit.unitType,
      habitLogs: updatedHabitLogs,
      target: habit.target,
    );

    habitsBox.putAt(habitIndex, updatedHabit);

    updatedHabits[habitIndex] = updatedHabit;
    emit(state.copyWith(habits: updatedHabits));
  }

  void _removeHabit(RemoveHabit event, Emitter<HabitsState> emit) {
    final updatedHabits = List<Habit>.from(state.habits);
    final habitIndex = updatedHabits.indexWhere((element) => element.id == event.habitId);

    habitsBox.deleteAt(habitIndex);

    updatedHabits.removeAt(habitIndex);

    emit(state.copyWith(habits: updatedHabits));
  }
}
