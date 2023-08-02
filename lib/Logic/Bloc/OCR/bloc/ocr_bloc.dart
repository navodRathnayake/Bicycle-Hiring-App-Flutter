import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ocr_event.dart';
part 'ocr_state.dart';

class OCRBloc extends Bloc<OCREvent, OCRState> {
  OCRBloc() : super(const OCRState.initial()) {
    on<OCRExtractingTextFromGallery>(_onOCRExtractingTextFromGallery);
    on<OCRExtractingTextFromCamera>(_onOCRExtractingTextFromCamera);
    on<OcrUserVerificationEvent>(_onOCRUserVerificationEvent);
  }

  Future<void> _onOCRExtractingTextFromGallery(
    OCRExtractingTextFromGallery event,
    Emitter<OCRState> emit,
  ) async {}

  Future<void> _onOCRExtractingTextFromCamera(
    OCRExtractingTextFromCamera event,
    Emitter<OCRState> emit,
  ) async {}

  Future<void> _onOCRUserVerificationEvent(
    OcrUserVerificationEvent event,
    Emitter<OCRState> emit,
  ) async {}
}
