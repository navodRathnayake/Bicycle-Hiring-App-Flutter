library register_send_notification_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Login/auth/register/data/data%20provider/register_send_notification_api.dart';
import 'package:flutter/material.dart';

class RegisterSendNotificationRepository {
  final RegisterSendNotificationApi api;
  const RegisterSendNotificationRepository({required this.api});

  Future<Map<String, dynamic>> getRegisterResponse() async {
    try {
      final rawResponse = await api.getRegisterRawData();
      final response =
          await convert.jsonDecode(rawResponse['body']) as Map<String, dynamic>;
      if (rawResponse['status'] == 200) {
        // var token = response['data']['token'].toString();
        // var email = response['data']['user']['email'].toString();
        // var name = response['data']['user']['name'].toString();
        // var id = response['data']['user']['id'].toString();
        // var msg = response['message'].toString();
        debugPrint(response.toString());
        // return {
        //   'result': 1,
        //   'body': {
        //     'token': token,
        //     'email': email,
        //     'name': name,
        //     'id': id,
        //     'message': msg,
        //   },
        // };
        return {};
      } else {
        return {
          'result': 0,
          'error': rawResponse['status code'],
        };
      }
    } catch (e) {
      debugPrint(e.toString());
      return {
        'error': e.toString(),
      };
    }
  }
}
