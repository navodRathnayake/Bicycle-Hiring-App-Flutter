library map_launcher;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapLauncher extends StatefulWidget {
  final ThemeData themeData;
  const MapLauncher({super.key, required this.themeData});

  @override
  State<MapLauncher> createState() => _MapLauncherState();
}

class _MapLauncherState extends State<MapLauncher> {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.google.com/maps/'));
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
