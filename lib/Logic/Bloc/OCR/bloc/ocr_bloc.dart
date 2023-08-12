import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/OCR/data/data%20provider/update_user_patch_api.dart';
import 'package:final_project/Logic/Bloc/OCR/data/repository%20provider/update_user_patch_repository.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/account_completion_bloc.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

part 'ocr_event.dart';
part 'ocr_state.dart';

class OCRBloc extends Bloc<OCREvent, OCRState> {
  final AccountCompletionBloc accountCompletionBloc;
  final AuthenticationRepository authenticationRepository;
  OCRBloc(
      {required this.accountCompletionBloc,
      required this.authenticationRepository})
      : super(const OCRState.initial()) {
    on<OCRExtractingTextFromGallery>(_onOCRExtractingTextFromGallery);
    on<OCRExtractingTextFromCamera>(_onOCRExtractingTextFromCamera);
    on<OCRUserVerificationEvent>(_onOCRUserVerificationEvent);
    on<OCRResetProcessEvent>(_onOCRResetProcessEvent);
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

      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      String text1 = recognizedText.text;
      debugPrint(text1);
      late List<String> idData = [];

      if (recognizedText.blocks.length == 13) {
        for (TextBlock block in recognizedText.blocks) {
          String text = block.text.toString();
          if (text.contains('4b.')) {
            text = text.replaceAll('4b.', '');
          } else if (text.contains('4a.')) {
            text = text.replaceAll('4a.', '');
          } else if (text.contains('3.')) {
            text = text.replaceAll('3.', '');
          } else if (text.contains('8.')) {
            text = text.replaceAll('8.', '');
          } else if (text.contains('1,2.')) {
            text = text.replaceAll('1,2.', '');
          } else if (text.contains('5.')) {
            text = text.replaceAll('5.', '');
          } else if (text.contains('4d.')) {
            text = text.replaceAll('4d.', '');
          }

          idData.add(text);
        }
        debugPrint(idData.toString());
        textRecognizer.close();
        debugPrint('\n----------------------------');
        debugPrint(idData.toString());
        debugPrint('\n----------------------------');
        debugPrint('List Length : ${idData.length}');

        Map<String, String> reqBody = {
          'name': idData[8].toString(),
          'blood group': idData[2].toString(),
          'license issued date': idData[4].toString(),
          'license expiry date': idData[3].toString(),
          'dob': idData[5].toString(),
          'license id': idData[9].toString(),
          'nic': idData[10].toString(),
        };

        debugPrint('License ID Number : ${reqBody['license id']}');
        debugPrint('License Expiry Date : ${reqBody['license expiry date']}');
        // network Process

        debugPrint('Request : ${reqBody.toString()}');
        emit(state.copyWith(
          status: OCRStatus.ocrSuccess,
          userData: reqBody,
        ));
      } else {
        emit(state.copyWith(
          msg: 'Blocks cannot be catched!',
          status: OCRStatus.ocrFailure,
        ));
      }
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
    OCRUserVerificationEvent event,
    Emitter<OCRState> emit,
  ) async {
    debugPrint('User Verified!!!!');

    try {
      emit(state.copyWith(status: OCRStatus.updateInprocess));
      await Future.delayed(const Duration(milliseconds: 500));

      final response =
          await UpdateUserPatchRepository(api: UpdateUserPatchApi(), reqBody: {
        "firstName": state.userData!['name'].toString(),
        "dateOfBirth": '1994-09-19',
        "nic": state.userData!['nic'].toString(),
        "bloodGroup": state.userData!['blood group'].toString(),
        "licenseIssueDate": '1994-09-19'
      }).getPatchUpdateRepository();

      debugPrint(response.toString());

      if (response['result'] == 1) {
        debugPrint('Updated Successfully');
        emit(state.copyWith(status: OCRStatus.updateSucsses));
        await Future.delayed(const Duration(milliseconds: 500));

        accountCompletionBloc.add(const AccountCompletionStepEvent(
            currentTappedStep: 3,
            currentCompletionStep: 2,
            progressIndicatorValue: 50));

        debugPrint('dsadsdasdadsadf f  fs dsd fs g fd g df  dfda d ');
        authenticationRepository.loading();
        await Future.delayed(const Duration(milliseconds: 800));
        authenticationRepository.rollBack();
      } else {
        debugPrint('Cannot Updated');
        emit(state.copyWith(status: OCRStatus.updateFailure));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: OCRStatus.updateFailure));
    }
  }

  Future<void> _onOCRResetProcessEvent(
    OCRResetProcessEvent event,
    Emitter<OCRState> emit,
  ) async {
    emit(state.copyWith(status: OCRStatus.initial));
  }
}
