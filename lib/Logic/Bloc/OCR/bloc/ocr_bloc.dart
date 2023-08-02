import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

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
  ) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      emit(state.copyWith(xfile: image));
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          msg: 'Could\'t capyure the image from gallery. Permition has denied!',
          status: OCRStatus.ocrFailure,
        ),
      );
    }
    // imported image from gallery
    try {
      emit(state.copyWith(
        status: OCRStatus.ocrProcess,
      ));

      final inputImage = InputImage.fromFilePath(state.xfile!.path);
      // final textDetector = GoogleMlKit.vision.textRecognizer();
      // RecognizedText recognizedText =
      //     await textDetector.processImage(inputImage);
      // await textDetector.close();

      // for (TextBlock block in recognizedText.blocks) {
      //   for (TextLine line in block.lines) {
      //     final String tempTextLine = line.text.toString();
      //     if (tempTextLine.isNotEmpty) {
      //       state.textLines!.add(tempTextLine);
      //     }
      //   }
      // }

      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      String text = recognizedText.text;
      debugPrint(text);
      // for (TextBlock block in recognizedText.blocks) {
      //   final Rect rect = block.boundingBox;
      //   final List<Point<int>> cornerPoints = block.cornerPoints;
      //   final String text = block.text;
      //   final List<String> languages = block.recognizedLanguages;

      //   for (TextLine line in block.lines) {
      //     // Same getters as TextBlock
      //     for (TextElement element in line.elements) {
      //       // Same getters as TextBlock
      //     }
      //   }
      // }
      textRecognizer.close();

      emit(state.copyWith(
        msg: 'Successfully Extracted Data',
        status: OCRStatus.ocrSuccess,
      ));

      debugPrint(state.textLines.toString());
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        msg: 'OCR Process Failure',
        status: OCRStatus.ocrFailure,
      ));
    }
  }

  Future<void> _onOCRExtractingTextFromCamera(
    OCRExtractingTextFromCamera event,
    Emitter<OCRState> emit,
  ) async {}

  Future<void> _onOCRUserVerificationEvent(
    OcrUserVerificationEvent event,
    Emitter<OCRState> emit,
  ) async {}
}
