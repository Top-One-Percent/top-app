part of 'habits_bloc.dart';

class HabitsState {
  final List<Habit> habits;

  HabitsState({required this.habits});

  HabitsState copyWith({List<Habit>? habits}) {
    return HabitsState(habits: habits ?? this.habits);
  }
}
