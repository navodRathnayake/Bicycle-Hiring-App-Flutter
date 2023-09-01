library constraints;

import 'package:final_project/Logic/Bloc/Cycling/bloc/cycling_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const page1color = Color(0xfffddcdf);
const page2color = Color(0xffffdcbd);

MaterialStateProperty<double?>? iconSize =
    MaterialStateProperty.all<double?>(32.0);
MaterialStateProperty<Color?>? iconColor =
    MaterialStateProperty.all<Color?>(Colors.white);

List<List<dynamic>> packages = [
  ['Hourly', '30 Minutes', 'Rs13.50', Packages.minutes30],
  ['Hourly', '60 Minutes', 'Rs25.50', Packages.minutes60],
  ['Hourly', '120 Minutes', 'Rs45.50', Packages.minutes120],
  ['Best Value', '1 Day', 'Rs175.50', Packages.day1],
];

String terms =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

String useLicense =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. It has and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

var creaditCardNumberMaskFormatter = MaskTextInputFormatter(
    mask: '####-####-####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var creaditCardDateMaskFormatter = MaskTextInputFormatter(
    mask: '##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var creaditCardCVCMaskFormatter = MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

Map<String, double> packagePool = {
  'min30': 13.50,
  'min60': 25.50,
  'min120': 45.50,
  'hour5': 175.50,
};

int transactionTypeAddCreadits = 1;
int transactionTypeCycling = 2;
