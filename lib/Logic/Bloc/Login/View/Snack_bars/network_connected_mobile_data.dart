library network_connected_mobile_data;

import 'package:flutter/material.dart';

final networkConnectedMobileDataSnackBar = SnackBar(
  duration: const Duration(seconds: 15),
  content: const Text('Network Has Restored!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {},
  ),
);
