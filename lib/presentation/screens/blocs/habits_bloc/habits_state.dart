part of 'habits_bloc.dart';

class HabitsState {
  final List<Habit> habits;
  final bool habitsRestarted;

  HabitsState({this.habitsRestarted=false, required this.habits});

  HabitsState copyWith({List<Habit>? habits, bool? habitsRestarted}) {
    return HabitsState(habits: habits ?? this.habits, habitsRestarted: habitsRestarted ?? this.habitsRestarted);
  }
}
