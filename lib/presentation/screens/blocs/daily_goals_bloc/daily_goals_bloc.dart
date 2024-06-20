import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'daily_goals_event.dart';
part 'daily_goals_state.dart';

class DailyGoalsBloc extends Bloc<DailyGoalsEvent, DailyGoalsState> {
  DailyGoalsBloc() : super(DailyGoalsInitial()) {
    on<DailyGoalsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
