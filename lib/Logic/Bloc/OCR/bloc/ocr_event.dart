part of 'ocr_bloc.dart';

abstract class OCREvent extends Equatable {
  const OCREvent();

  @override
  List<Object> get props => [];
}

class OCRExtractingTextFromGallery extends OCREvent {}

class OCRExtractingTextFromCamera extends OCREvent {}

class OcrUserVerificationEvent extends OCREvent {}
