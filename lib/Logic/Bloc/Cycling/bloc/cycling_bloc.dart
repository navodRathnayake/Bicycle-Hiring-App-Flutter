import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cycling_event.dart';
part 'cycling_state.dart';

class CyclingBloc extends Bloc<CyclingEvent, CyclingState> {
  CyclingBloc() : super(const CyclingState.initial()) {
    on<CyclePackagePressEvent>(_onPressEvent);
  }
}

Future<void> _onPressEvent(
  CyclePackagePressEvent event,
  Emitter<CyclingState> emit,
) async {
  switch (event.index) {
    case 0:
      emit(const CyclingState.minutes30());
      break;
    case 1:
      emit(const CyclingState.minutes60());
      break;

    case 2:
      emit(const CyclingState.minutes120());
      break;

    case 3:
      emit(const CyclingState.day1());
      break;
    default:
      emit(const CyclingState.minutes120());
      break;
  }
}
