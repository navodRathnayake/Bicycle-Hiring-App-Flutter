library verify_ocr_success;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';
import 'package:final_project/Logic/Bloc/OCR/bloc/ocr_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOCRSuccess extends StatelessWidget {
  final ThemeData themeData;
  const VerifyOCRSuccess({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<OCRBloc, OCRState>(
              builder: (context, state) {
                if (state.status == OCRStatus.ocrSuccess) {
                  return UserDataBodyView(themeData: themeData);
                } else if (state.status == OCRStatus.updateInprocess) {
                  return const CircularProgressIndicator();
                } else if (state.status == OCRStatus.updateSucsses) {
                  return const AccountHasVerified();
                }
                if (state.status == OCRStatus.updateFailure) {
                  return const UpdateFailureView();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserDataBodyView extends StatelessWidget {
  final ThemeData themeData;
  const UserDataBodyView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OCRBloc, OCRState>(
      builder: (context, state) {
        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('VERIFY YOUR',
                    style: TextStyle(fontSize: 25, letterSpacing: 0)),
                const Text('ACCOUNT'),
                const ColumnSpacer(height: 30),
                TextFormField(
                  initialValue: state.userData!['name'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'User Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabled: true,
                  ),
                  keyboardType: TextInputType.none,
                ),
                const ColumnSpacer(height: 10),
                TextFormField(
                  initialValue: state.userData!['nic'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'NIC',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabled: true,
                  ),
                  keyboardType: TextInputType.none,
                ),
                const ColumnSpacer(height: 10),
                // TextFormField(
                //   initialValue: state.userData!['license id'],
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     labelText: 'License ID Number',
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     enabled: true,
                //   ),
                //   keyboardType: TextInputType.none,
                // ),
                const ColumnSpacer(height: 10),
                TextFormField(
                  initialValue: state.userData!['license issued date'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'License Issued Date',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabled: true,
                  ),
                  keyboardType: TextInputType.none,
                ),
                const ColumnSpacer(height: 10),
                // TextFormField(
                //   initialValue: state.userData!['license expiry date'],
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     labelText: 'License Expiry Date',
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     enabled: true,
                //   ),
                //   keyboardType: TextInputType.none,
                // ),
                const ColumnSpacer(height: 10),
                TextFormField(
                  initialValue: state.userData!['dob'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Date of Birth',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabled: true,
                  ),
                  keyboardType: TextInputType.none,
                ),
                const ColumnSpacer(height: 10),
                TextFormField(
                  initialValue: state.userData!['blood group'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Blood Group',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabled: true,
                  ),
                  keyboardType: TextInputType.none,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DialogBoxSecondaryButton(
                    themeData: themeData,
                    label: 'Try Again',
                    onTap: Navigator.of(context).pop),
                DialogBoxOkButton(
                    label: 'Verify Account',
                    onTap: () {
                      BlocProvider.of<OCRBloc>(context)
                          .add(OCRUserVerificationEvent());
                    }),
              ],
            ),
          ],
        );
      },
    );
  }
}

class AccountHasVerified extends StatelessWidget {
  const AccountHasVerified({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ColumnSpacer(height: 70),
          Image.asset('Assets/icons/verify.png'),
          const ColumnSpacer(height: 30),
          const Text('YOUR ACCOUNT',
              style: TextStyle(fontSize: 30, letterSpacing: 0)),
          const ColumnSpacer(height: 10),
          const Text('HAS', style: TextStyle(fontSize: 20, letterSpacing: 0)),
          const Text('VERIFIED!',
              style: TextStyle(fontSize: 25, letterSpacing: 0)),
          const ColumnSpacer(height: 30),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class UpdateFailureView extends StatelessWidget {
  const UpdateFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OCRBloc, OCRState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ColumnSpacer(height: 70),
                Image.asset('Assets/icons/sad.png'),
                const ColumnSpacer(height: 10),
                const Text('Could\'t',
                    style: TextStyle(fontSize: 25, letterSpacing: 0)),
                const ColumnSpacer(height: 10),
                const Text('Catch Up!',
                    style: TextStyle(fontSize: 25, letterSpacing: 0)),
                Text('ERROR _${state.msg}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red)),
                const ColumnSpacer(height: 30),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<OCRBloc>(context).add(OCRResetProcessEvent());
                },
                child: const Text('Try Again'))
          ],
        );
      },
    );
  }
}
