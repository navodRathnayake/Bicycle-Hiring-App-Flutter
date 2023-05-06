library network_disconnected;

import 'package:flutter/material.dart';

final networkDisconnectedSnackBar = SnackBar(
  duration: const Duration(seconds: 15),
  content: const Text('Network Has Disconnected!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {},
  ),
);
