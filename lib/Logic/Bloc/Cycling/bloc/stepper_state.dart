part of 'stepper_bloc.dart';

class StepperState extends Equatable {
  final int currentStep;

  const StepperState._({this.currentStep = 0});

  const StepperState.initial() : this._();
  const StepperState.step1() : this._(currentStep: 1);
  const StepperState.step2() : this._(currentStep: 2);
  const StepperState.step3() : this._(currentStep: 3);

  @override
  List<Object?> get props => [currentStep];
}
