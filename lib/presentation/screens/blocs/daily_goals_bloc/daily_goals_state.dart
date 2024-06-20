part of 'daily_goals_bloc.dart';

class DailyGoalsState {
  final List<DailyGoal> dailyGoals;

  DailyGoalsState({this.dailyGoals = const []});

  DailyGoalsState copyWith({
    List<DailyGoal>? dailyGoals,
  }) {
    return DailyGoalsState(
      dailyGoals: dailyGoals ?? this.dailyGoals,
    );
  }
}
