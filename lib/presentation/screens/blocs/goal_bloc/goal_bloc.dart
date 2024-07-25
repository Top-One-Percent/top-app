import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top/domain/models/goal.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final Box<Goal> goalsBox;

  GoalBloc(this.goalsBox) : super(GoalState(isLoading: true)) {
    on<LoadGoals>(_loadGoals);
    on<AddGoal>(_addGoal);
    on<UpdateGoal>(_updateGoal);
    on<RemoveGoal>(_removeGoal);
    on<EditGoal>(_editGoal);
  }

  void _loadGoals(LoadGoals event, Emitter<GoalState> emit) {
    final goals = goalsBox.values.toList();
    emit(state.copyWith(goals: goals, isLoading: false));
  }

  void _addGoal(AddGoal event, Emitter<GoalState> emit) {
    final newGoal = Goal(
        name: event.name, target: event.target, color: event.color, targetDate: event.targetDate);
    goalsBox.add(newGoal);

    final updatedGoals = List<Goal>.from(state.goals)..add(newGoal);
    emit(state.copyWith(goals: updatedGoals));
  }

  void _editGoal(EditGoal event, Emitter<GoalState> emit) {
    final logs = List<Log>.from(state.goals[event.goalId].logs);

    final editedGoal = Goal(
        name: event.name,
        target: event.target,
        color: event.color,
        targetDate: event.targetDate,
        logs: logs);

    goalsBox.putAt(event.goalId, editedGoal);

    final updatedGoals = List<Goal>.from(state.goals);

    updatedGoals[event.goalId] = editedGoal;

    emit(state.copyWith(goals: updatedGoals));
  }

  void _updateGoal(UpdateGoal event, Emitter<GoalState> emit) {
    final updatedGoals = List<Goal>.from(state.goals);
    final goal = updatedGoals[event.id];
    final updatedLogs = List<Log>.from(goal.logs)
      ..add(Log(date: DateTime.now(), currentValue: event.newValue));
    final updatedGoal = Goal(
        name: goal.name,
        target: goal.target,
        color: goal.color,
        logs: updatedLogs,
        targetDate: goal.targetDate);

    goalsBox.putAt(event.id, updatedGoal);

    updatedGoals[event.id] = updatedGoal;
    emit(state.copyWith(goals: updatedGoals));
  }

  void _removeGoal(RemoveGoal event, Emitter<GoalState> emit) {
    final updatedGoals = List<Goal>.from(state.goals);

    final goalIndex = updatedGoals.indexWhere((goal) => goal.id == event.id);

    updatedGoals.removeAt(goalIndex);

    goalsBox.deleteAt(goalIndex);

    emit(state.copyWith(goals: updatedGoals));
  }
}
