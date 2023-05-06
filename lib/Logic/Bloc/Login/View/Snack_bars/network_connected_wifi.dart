library network_connected_wifi;

import 'package:flutter/material.dart';

final networkConnectedWifiSnackBar = SnackBar(
  duration: const Duration(seconds: 15),
  content: const Text('Network Has Restored!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {},
  ),
);
