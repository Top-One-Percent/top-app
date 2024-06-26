part of 'habits_bloc.dart';

abstract class HabitsEvent {}

class LoadHabits extends HabitsEvent {}

class AddHabit extends HabitsEvent {
  final String name;
  final List<int> frequency;
  final List<String>? remindersTime;
  final List<String>? steps;
  final String? linkedGoalId;
  final Color color;
  final String icon;
  final String unitType;
  final double target;

  AddHabit({
    required this.name,
    required this.frequency,
    this.remindersTime,
    this.steps,
    this.linkedGoalId,
    required this.color,
    required this.icon,
    required this.unitType,
    required this.target,
  });
}

class EditHabit extends HabitsEvent {
  final String habitId;
  final String name;
  final List<int> frequency;
  final List<String>? remindersTime;
  final List<String>? steps;
  final String? linkedGoalId;
  final Color color;
  final String icon;
  final String unitType;
  final double target;

  EditHabit({
    required this.habitId,
    required this.name,
    required this.frequency,
    this.remindersTime,
    this.steps,
    this.linkedGoalId,
    required this.color,
    required this.icon,
    required this.unitType,
    required this.target,
  });
}

class RemoveHabit extends HabitsEvent {
  final String habitId;

  RemoveHabit({required this.habitId});
}

class UpdateHabit extends HabitsEvent {
  final String habitId;
  final double newComplianceRate;

  UpdateHabit({required this.habitId, required this.newComplianceRate});
}
