part of 'account_completion_bloc.dart';

abstract class AccountCompletionEvent extends Equatable {
  const AccountCompletionEvent();

  @override
  List<Object> get props => [];
}

class AccountCompletionStepEvent extends AccountCompletionEvent {
  final int currentTappedStep;
  final int currentCompletionStep;
  final double progressIndicatorValue;

  const AccountCompletionStepEvent({
    required this.currentTappedStep,
    required this.currentCompletionStep,
    required this.progressIndicatorValue,
  });
}
