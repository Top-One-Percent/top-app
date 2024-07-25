part of 'goal_bloc.dart';

abstract class GoalEvent {}

class LoadGoals extends GoalEvent {}

class AddGoal extends GoalEvent {
  final String name;
  final int target;
  final Color color;
  final DateTime targetDate;

  AddGoal(this.name, this.target, this.color, this.targetDate);
}

class EditGoal extends GoalEvent {
  final int goalId;
  final String name;
  final int target;
  final Color color;
  final DateTime targetDate;

  EditGoal(this.goalId, this.name, this.target, this.color, this.targetDate);
}

class UpdateGoal extends GoalEvent {
  final int id;
  final int newValue;

  UpdateGoal(this.id, this.newValue);
}

class RemoveGoal extends GoalEvent {
  final String id;

  RemoveGoal(this.id);
}
