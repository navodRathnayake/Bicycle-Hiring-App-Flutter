part of 'stepper_bloc.dart';

enum Package { min30, min60, min120, hour5 }

class StepperState extends Equatable {
  final Bicycle bicycle;
  final int currentStep;
  final Package package;

  const StepperState._(
      {this.currentStep = 0,
      this.bicycle = const Bicycle(),
      this.package = Package.min120});
  const StepperState(
      {required this.bicycle,
      required this.currentStep,
      this.package = Package.min120});
  const StepperState.initial() : this._();
  const StepperState.step1() : this._(currentStep: 1);
  const StepperState.step2() : this._(currentStep: 2);
  const StepperState.step3() : this._(currentStep: 3);

  StepperState copyWith({
    Bicycle? bicycle,
    int? currentStep,
    Package? package,
  }) {
    return StepperState(
      bicycle: bicycle ?? this.bicycle,
      currentStep: currentStep ?? this.currentStep,
      package: package ?? this.package,
    );
  }

  @override
  List<Object?> get props => [currentStep, bicycle, package];
}
