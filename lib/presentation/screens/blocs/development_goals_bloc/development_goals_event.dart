part of 'development_goals_bloc.dart';

abstract class DevelopmentGoalsEvent {}

class LoadDevGoals extends DevelopmentGoalsEvent {}

class AddDevGoal extends DevelopmentGoalsEvent {
  final DevelopmentList list;
  final String devGoalName;

  AddDevGoal({required this.list, required this.devGoalName});
}

class EditDevGoal extends DevelopmentGoalsEvent {
  final DevelopmentList list;
  final int devGoalId;
  final String newName;

  EditDevGoal({required this.list, required this.devGoalId, required this.newName});
}

class RemoveDevGoal extends DevelopmentGoalsEvent {
  final DevelopmentList list;
  final int devGoalId;

  RemoveDevGoal({required this.list, required this.devGoalId});
}

class ToggleDevGoalList extends DevelopmentGoalsEvent {
  final int currentListId;
  final DevelopmentList currentList;

  ToggleDevGoalList({required this.currentList, required this.currentListId});
}
