import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top/domain/models/daily_goal.dart';

part 'daily_goals_event.dart';
part 'daily_goals_state.dart';

class DailyGoalsBloc extends Bloc<DailyGoalsEvent, DailyGoalsState> {
  final Box<DailyGoal> dailyGoalsBox;
  DailyGoalsBloc(this.dailyGoalsBox) : super(DailyGoalsState()) {
    on<LoadDailyGoals>(_loadDailyGoals);
    on<AddDailyGoal>(_addDailyGoal);
    on<EditDailyGoal>(_editDailyGoal);
    on<RemoveDailyGoal>(_removeDailyGoal);
    on<ToggleDailyGoalStatus>(_toggleDailyGoalStatus);
  }

  void _loadDailyGoals(LoadDailyGoals event, Emitter<DailyGoalsState> emit) {
    final dailyGoals = dailyGoalsBox.values.toList();
    emit(state.copyWith(dailyGoals: dailyGoals));
  }

  void _addDailyGoal(AddDailyGoal event, Emitter<DailyGoalsState> emit) {
    final newDailyGoal = DailyGoal(name: event.dailyGoalName, false);

    dailyGoalsBox.add(newDailyGoal);

    final updatedDailyGoals = List<DailyGoal>.from(state.dailyGoals)..add(newDailyGoal);

    emit(state.copyWith(dailyGoals: updatedDailyGoals));
  }

  void _editDailyGoal(EditDailyGoal event, Emitter<DailyGoalsState> emit) {
    final editedDailyGoal = DailyGoal(name: event.newName, false);

    dailyGoalsBox.putAt(event.dailyGoalId, editedDailyGoal);

    final updatedDailyGoals = List<DailyGoal>.from(state.dailyGoals);

    updatedDailyGoals[event.dailyGoalId] = editedDailyGoal;

    emit(state.copyWith(dailyGoals: updatedDailyGoals));
  }

  void _removeDailyGoal(RemoveDailyGoal event, Emitter<DailyGoalsState> emit) {
    final updatedDailyGoals = List<DailyGoal>.from(state.dailyGoals)..removeAt(event.dailyGoalId);

    dailyGoalsBox.deleteAt(event.dailyGoalId);

    emit(state.copyWith(dailyGoals: updatedDailyGoals));
  }

  void _toggleDailyGoalStatus(ToggleDailyGoalStatus event, Emitter<DailyGoalsState> emit) {
    final currentGoal = state.dailyGoals[event.goalId];
    final newGoal = DailyGoal(!currentGoal.isCompleted, name: currentGoal.name);

    final updatedDailyGoals = List<DailyGoal>.from(state.dailyGoals);
    updatedDailyGoals[event.goalId] = newGoal;

    dailyGoalsBox.putAt(event.goalId, newGoal);
    emit(state.copyWith(dailyGoals: updatedDailyGoals));
  }
}
