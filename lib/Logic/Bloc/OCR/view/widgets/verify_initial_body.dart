library verify_initial_body;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/OCR/bloc/ocr_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyInitialBody extends StatelessWidget {
  final ThemeData themeData;
  const VerifyInitialBody({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const ColumnSpacer(height: 20),
                          ListTile(
                            title: const Text('Gallery'),
                            leading: Image.asset(
                              'Assets/icons/gallery.png',
                              scale: 2,
                              color: themeData.colorScheme.onBackground,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<OCRBloc>(context)
                                  .add(OCRExtractingTextFromGallery());
                            },
                          ),
                          ListTile(
                            title: const Text('Camera'),
                            leading: Image.asset(
                              'Assets/icons/camera.png',
                              scale: 2,
                              color: themeData.colorScheme.onBackground,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Builder(builder: (context) {
                return BlocBuilder<OCRBloc, OCRState>(
                  builder: (context, state) {
                    if (state.status == OCRStatus.initial) {
                      return Image.asset(
                        'Assets/icons/finger.png',
                        color: themeData.colorScheme.onBackground,
                        scale: 6,
                      );
                    }
                    if (state.status == OCRStatus.ocrProcess) {
                      return const CircularProgressIndicator();
                    } else {
                      return Container();
                    }
                  },
                );
              }),
            ),
            const ColumnSpacer(height: 30),
            const Text(
              'VERIFY',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
              ),
            ),
            const ColumnSpacer(height: 10),
            const Text(
              'YOUR ACCOUNT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 10,
              ),
            ),
            const ColumnSpacer(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                useLicense,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
