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
