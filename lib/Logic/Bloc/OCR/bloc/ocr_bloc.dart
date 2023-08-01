import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ocr_event.dart';
part 'ocr_state.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  OcrBloc() : super(OcrInitial()) {
    on<OcrEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
