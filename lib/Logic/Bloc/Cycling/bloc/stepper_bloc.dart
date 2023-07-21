import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc() : super(const StepperState.step1()) {
    on<CycleStepperChanged>(_onStepperChanged);
  }
}

Future<void> _onStepperChanged(
  CycleStepperChanged event,
  Emitter<StepperState> emit,
) async {
  switch (event.currentStep) {
    case 0:
      emit(const StepperState.step1());
      break;
    case 1:
      emit(const StepperState.step2());
      break;

    case 2:
      emit(const StepperState.step3());
      break;

    default:
      emit(const StepperState.step1());
      break;
  }
}
