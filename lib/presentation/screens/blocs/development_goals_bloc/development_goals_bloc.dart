import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top/domain/models/models.dart';

part 'development_goals_event.dart';
part 'development_goals_state.dart';

class DevelopmentGoalsBloc extends Bloc<DevelopmentGoalsEvent, DevelopmentGoalsState> {
  final Box<DevelopmentGoal> improvGoalsBox;
  final Box<DevelopmentGoal> keepGoalsBox;

  DevelopmentGoalsBloc(this.improvGoalsBox, this.keepGoalsBox) : super(DevelopmentGoalsState()) {
    on<LoadDevGoals>(_loadDevGoals);
    on<AddDevGoal>(_addDevGoal);
    on<EditDevGoal>(_editDevGoal);
    on<RemoveDevGoal>(_removeDevGoal);
    on<ToggleDevGoalList>(_toggleDevGoalList);
  }

  void _loadDevGoals(LoadDevGoals event, Emitter<DevelopmentGoalsState> emit) {
    final improvGoals = improvGoalsBox.values.toList();
    final keepGoals = keepGoalsBox.values.toList();

    emit(state.copyWith(toImprove: improvGoals, toKeep: keepGoals));
  }

  void _addDevGoal(AddDevGoal event, Emitter<DevelopmentGoalsState> emit) {
    final newDevGoal = DevelopmentGoal(name: event.devGoalName, false);

    final updatedDevGoals = List<DevelopmentGoal>.from(
        event.list == DevelopmentList.toImprove ? state.toImprove : state.toKeep)
      ..add(newDevGoal);

    if (event.list == DevelopmentList.toImprove) {
      improvGoalsBox.add(newDevGoal);
      emit(state.copyWith(toImprove: updatedDevGoals));
    } else {
      keepGoalsBox.add(newDevGoal);
      emit(state.copyWith(toKeep: updatedDevGoals));
    }
  }

  void _editDevGoal(EditDevGoal event, Emitter<DevelopmentGoalsState> emit) {
    final bool isToImprov = event.list == DevelopmentList.toImprove ? true : false;

    final editedDevGoal = DevelopmentGoal(name: event.newName, false);

    final updatedDevGoals = List<DevelopmentGoal>.from(isToImprov ? state.toImprove : state.toKeep);
    updatedDevGoals[event.devGoalId] = editedDevGoal;

    if (isToImprov) {
      improvGoalsBox.putAt(event.devGoalId, editedDevGoal);
      emit(state.copyWith(toImprove: updatedDevGoals));
    } else {
      keepGoalsBox.putAt(event.devGoalId, editedDevGoal);
      emit(state.copyWith(toKeep: updatedDevGoals));
    }
  }

  void _removeDevGoal(RemoveDevGoal event, Emitter<DevelopmentGoalsState> emit) {
    final bool isToImprov = event.list == DevelopmentList.toImprove ? true : false;

    final updatedDevGoals = List<DevelopmentGoal>.from(isToImprov ? state.toImprove : state.toKeep)
      ..removeAt(event.devGoalId);

    if (isToImprov) {
      improvGoalsBox.deleteAt(event.devGoalId);
      emit(state.copyWith(toImprove: updatedDevGoals));
    } else {
      keepGoalsBox.deleteAt(event.devGoalId);
      emit(state.copyWith(toKeep: updatedDevGoals));
    }
  }

  void _toggleDevGoalList(ToggleDevGoalList event, Emitter<DevelopmentGoalsState> emit) {
    late DevelopmentGoal goal;

    if (event.currentList == DevelopmentList.toImprove) {
      goal = state.toImprove[event.currentListId];

      improvGoalsBox.deleteAt(event.currentListId);

      final updatedToImprov = List<DevelopmentGoal>.from(state.toImprove)
        ..removeAt(event.currentListId);

      keepGoalsBox.add(goal);

      final updatedToKeep = List<DevelopmentGoal>.from(state.toKeep)..add(goal);

      emit(state.copyWith(toKeep: updatedToKeep, toImprove: updatedToImprov));
    } else if (event.currentList == DevelopmentList.toKeep) {
      goal = state.toKeep[event.currentListId];

      keepGoalsBox.deleteAt(event.currentListId);

      final updatedToKeep = List<DevelopmentGoal>.from(state.toKeep)..removeAt(event.currentListId);

      improvGoalsBox.add(goal);

      final updatedToImprov = List<DevelopmentGoal>.from(state.toImprove)..add(goal);

      emit(state.copyWith(toKeep: updatedToKeep, toImprove: updatedToImprov));
    }
  }
}
