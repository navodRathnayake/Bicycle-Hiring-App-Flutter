library main;

import 'dart:io';

import 'package:final_project/Logic/Bloc/Login/auth/register/data/data%20provider/register_send_notification_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/data/repository/register_send_notification_repository.dart';
import 'package:final_project/Services/push%20notification/notification.dart';
import 'package:final_project/Services/push%20notification/push_notification_healper_class.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:final_project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService().initNotification();
  HttpOverrides.global = MyHttpOverrides();
  final messaging = FirebaseMessaging.instance;
  // final _messageStreamController = BehaviorSubject<RemoteMessage>();
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  String? token = await messaging.getToken();
  debugPrint('Registration Token=$token');
  debugPrint('Permission granted: ${settings.authorizationStatus}');

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Handling a foreground message: ${message.messageId}');
  //   print('Message data: ${message.data}');
  //   print('Message notification: ${message.notification?.title}');
  //   print('Message notification: ${message.notification?.body}');

  //   _messageStreamController.sink.add(message);
  // });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification}');
      PushNotificationHealperClass().showNotification(
        title: message.notification?.title!,
        body: message.notification?.body!,
      );
    }
  });

  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
