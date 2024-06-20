part of 'daily_goals_bloc.dart';

abstract class DailyGoalsEvent {}

class LoadDailyGoals extends DailyGoalsEvent {}

class AddDailyGoal extends DailyGoalsEvent {
  final String dailyGoalName;

  AddDailyGoal({required this.dailyGoalName});
}

class EditDailyGoal extends DailyGoalsEvent {
  final int dailyGoalId;
  final String newName;

  EditDailyGoal({required this.dailyGoalId, required this.newName});
}

class RemoveDailyGoal extends DailyGoalsEvent {
  final int dailyGoalId;

  RemoveDailyGoal({required this.dailyGoalId});
}
