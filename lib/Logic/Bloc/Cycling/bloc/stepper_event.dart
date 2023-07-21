part of 'stepper_bloc.dart';

abstract class StepperEvent extends Equatable {
  const StepperEvent();

  @override
  List<Object> get props => [];
}

class CycleStepperChanged extends StepperEvent {
  final int currentStep;
  const CycleStepperChanged({required this.currentStep});
}
