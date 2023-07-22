import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_completion_event.dart';
part 'account_completion_state.dart';

class AccountCompletionBloc
    extends Bloc<AccountCompletionEvent, AccountCompletionState> {
  AccountCompletionBloc() : super(const AccountCompletionState.initial()) {
    on<AccountCompletionStepEvent>(_onPerformStep);
  }
}

Future<void> _onPerformStep(
  AccountCompletionStepEvent event,
  Emitter<AccountCompletionState> emit,
) async {
  emit(AccountCompletionState(
    currentTappedStep: event.currentTappedStep,
    currentCompletionStep: event.currentCompletionStep,
    progressIndicatorValue: event.progressIndicatorValue,
  ));
}
