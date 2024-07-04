part of 'goal_bloc.dart';

class GoalState {
  final List<Goal> goals;
  final bool isLoading;

  GoalState({this.goals = const [], this.isLoading = false});

  GoalState copyWith({
    List<Goal>? goals,
    bool? isLoading,
  }) {
    return GoalState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
