library register_send_notification_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Login/auth/register/data/data%20provider/register_send_notification_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';

class RegisterSendNotificationRepository {
  final RegisterSendNotificationApi api;
  const RegisterSendNotificationRepository({required this.api});

  Future<Map<String, dynamic>> getRegisterResponse() async {
    var userBearerToken = await SqfliteHelper.instance.readBearerToken();
    // try {
    final rawResponse =
        await api.getRegisterRawData(bearerToken: userBearerToken);
    final response =
        await convert.jsonDecode(rawResponse['body']) as Map<String, dynamic>;
    if (rawResponse['status'] == 200) {
      debugPrint(response.toString());

      return {
        'result': 1,
      };
    } else {
      return {
        'result': 0,
        'error': rawResponse['status code'],
      };
    }
  }
  // catch (e) {
  // debugPrint(e.toString());
  // return {
  //   'error': e.toString(),
  // };
}
  // }
// }
