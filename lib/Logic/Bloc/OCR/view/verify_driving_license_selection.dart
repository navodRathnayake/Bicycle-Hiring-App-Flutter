library verify_driving_license_selection;

import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Logic/Bloc/OCR/bloc/ocr_bloc.dart';
import 'package:final_project/Logic/Bloc/OCR/view/widgets/verify_initial_body.dart';
import 'package:final_project/Logic/Bloc/OCR/view/widgets/verify_ocr_failure.dart';
import 'package:final_project/Logic/Bloc/OCR/view/widgets/verify_ocr_success.dart';
import 'package:final_project/Logic/Bloc/OCR/view/widgets/verify_update_failure.dart';
import 'package:final_project/Logic/Bloc/OCR/view/widgets/verify_update_success.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyDrivingLicenseSelection extends StatelessWidget {
  final ThemeData themeData;
  const VerifyDrivingLicenseSelection({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Image.asset(
                  'Assets/icons/back_arrow.png',
                  scale: 2,
                  color: themeData.colorScheme.onBackground,
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: PopUpSettingsMenu(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                  icon: CustomSettingsIcon(
                    themeData: themeData,
                  ))),
        ],
      ),
      body: BlocBuilder<OCRBloc, OCRState>(
        builder: (context, state) {
          if (state.status == OCRStatus.initial) {
            return VerifyInitialBody(themeData: themeData);
          } else if (state.status == OCRStatus.ocrProcess) {
            return VerifyInitialBody(themeData: themeData);
          } else if (state.status == OCRStatus.ocrSuccess) {
            return const VerifyOCRSuccess();
          } else if (state.status == OCRStatus.ocrFailure) {
            return const VerifyOCRFailure();
          } else if (state.status == OCRStatus.updateSucsses) {
            return const VerifyUpdateSuccess();
          } else if (state.status == OCRStatus.updateFailure) {
            return const VerifyUpdateFailure();
          } else {
            return VerifyInitialBody(themeData: themeData);
          }
        },
      ),
    );
  }
}
