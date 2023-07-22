part of 'account_completion_bloc.dart';

class AccountCompletionState extends Equatable {
  final int currentTappedStep;
  final int currentCompletionStep;
  final double progressIndicatorValue;

  const AccountCompletionState._(
      {this.currentTappedStep = 0,
      this.currentCompletionStep = 1,
      this.progressIndicatorValue = 25});
  const AccountCompletionState.initial() : this._();
  const AccountCompletionState({
    required this.currentTappedStep,
    required this.currentCompletionStep,
    required this.progressIndicatorValue,
  });
  @override
  List<Object?> get props => [currentTappedStep, currentCompletionStep];
}
