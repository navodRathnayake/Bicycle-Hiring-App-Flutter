library verify_ocr_failure;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/OCR/bloc/ocr_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOCRFailure extends StatelessWidget {
  const VerifyOCRFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OCRBloc, OCRState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      const ColumnSpacer(height: 10),
                      const Text(
                        'The model cannot identify the text \nblocks in the uploaded image',
                        textAlign: TextAlign.center,
                      ),
                      const ColumnSpacer(height: 30),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<OCRBloc>(context)
                            .add(OCRResetProcessEvent());
                      },
                      child: const Text('Try Again'))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
