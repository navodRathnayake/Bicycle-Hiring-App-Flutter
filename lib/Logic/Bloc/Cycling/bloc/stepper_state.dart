part of 'stepper_bloc.dart';

enum Package { min30, min60, min120, hour5 }

class StepperState extends Equatable {
  final Bicycle bicycle;
  final int currentStep;
  final Package package;
  final String date;

  const StepperState._({
    this.currentStep = 0,
    this.bicycle = const Bicycle(),
    this.package = Package.min120,
    this.date = '2012-02-27 13:27:00.123456789z',
  });

  const StepperState({
    required this.bicycle,
    required this.currentStep,
    this.package = Package.min120,
    this.date = '2012-02-27 13:27:00.123456789z',
  });

  const StepperState.initial() : this._();
  const StepperState.step1() : this._(currentStep: 1);
  const StepperState.step2() : this._(currentStep: 2);
  const StepperState.step3() : this._(currentStep: 3);
  const StepperState.rollback()
      : this._(
          bicycle: const Bicycle(),
          currentStep: 1,
          package: Package.min120,
          date: '2012-02-27 13:27:00.123456789z',
        );

  StepperState copyWith({
    Bicycle? bicycle,
    int? currentStep,
    Package? package,
    String? date,
  }) {
    return StepperState(
      bicycle: bicycle ?? this.bicycle,
      currentStep: currentStep ?? this.currentStep,
      package: package ?? this.package,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [currentStep, bicycle, package, date];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bicycle': bicycle,
      'currentStep': currentStep,
      'package': package,
      'date': date
    };
  }

  factory StepperState.fromMap(Map<String, dynamic> map) {
    return StepperState(
        bicycle: map['bicycle'] as Bicycle,
        currentStep: map['currentStep'] as int,
        package: map['package'] as Package,
        date: map['date'] as String);
  }

  String toJson() => json.encode(toMap());

  factory StepperState.fromJson(String source) =>
      StepperState.fromMap(json.decode(source) as Map<String, dynamic>);
}
