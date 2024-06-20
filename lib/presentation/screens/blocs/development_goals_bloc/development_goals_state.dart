part of 'development_goals_bloc.dart';

enum DevelopmentList { toImprove, toKeep }

class DevelopmentGoalsState {
  final List<DevelopmentGoal> toImprove;
  final List<DevelopmentGoal> toKeep;

  DevelopmentGoalsState({this.toImprove = const [], this.toKeep = const []});

  DevelopmentGoalsState copyWith({
    List<DevelopmentGoal>? toImprove,
    List<DevelopmentGoal>? toKeep,
  }) {
    return DevelopmentGoalsState(
      toImprove: toImprove ?? this.toImprove,
      toKeep: toKeep ?? this.toKeep,
    );
  }
}
