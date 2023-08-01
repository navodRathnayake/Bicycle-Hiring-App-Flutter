part of 'ocr_bloc.dart';

abstract class OcrState extends Equatable {
  const OcrState();
  
  @override
  List<Object> get props => [];
}

class OcrInitial extends OcrState {}
