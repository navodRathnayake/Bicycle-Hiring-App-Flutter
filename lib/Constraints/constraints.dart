library constraints;

import 'package:final_project/Logic/Bloc/Cycling/bloc/cycling_bloc.dart';
import 'package:flutter/material.dart';

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
