part of 'goal_bloc.dart';

class GoalState {
  final List<Goal> goals;

  GoalState({this.goals = const []});

  GoalState copyWith({
    List<Goal>? goals,
  }) {
    return GoalState(
      goals: goals ?? this.goals,
    );
  }
}
