part of 'stepper_bloc.dart';

abstract class StepperEvent extends Equatable {
  const StepperEvent();

  @override
  List<Object> get props => [];
}

class CycleStepperChanged extends StepperEvent {
  final int currentStep;
  const CycleStepperChanged({required this.currentStep});

  @override
  List<Object> get props => [currentStep];
}

class BicycleInfoPassEvent extends StepperEvent {
  final Bicycle bicycle;
  const BicycleInfoPassEvent({required this.bicycle});

  @override
  List<Object> get props => [bicycle];
}

class PackageOnChangedEvent extends StepperEvent {
  final int index;
  const PackageOnChangedEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class StepperRollBackEvent extends StepperEvent {}
