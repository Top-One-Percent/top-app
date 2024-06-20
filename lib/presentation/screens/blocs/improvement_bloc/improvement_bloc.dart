import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'improvement_event.dart';
part 'improvement_state.dart';

class ImprovementBloc extends Bloc<ImprovementEvent, ImprovementState> {
  ImprovementBloc() : super(ImprovementInitial()) {
    on<ImprovementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
