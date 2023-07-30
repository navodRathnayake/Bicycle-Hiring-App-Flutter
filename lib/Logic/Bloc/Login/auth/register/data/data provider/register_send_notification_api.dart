library register_send_notification_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterSendNotificationApi {
  final Map<String, String> reqBody;
  final String bearerToken;

  // String baseUrl = '192.168.1.161:8000';
  String endPoint = register['/send-notification']!;

  RegisterSendNotificationApi(
      {required this.reqBody, required this.bearerToken});

  Future<Map<String, dynamic>> getRegisterRawData(
      {required String bearerToken}) async {
    // try {
    var url = Uri.http(domain, endPoint);

    debugPrint(url.toString());

    var response = await http.post(
      url,
      body: jsonEncode({"token": reqBody['device token'].toString()}),
      headers: {
        'Content-type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
        'Authorization': 'Bearer $bearerToken'
      },
    );

    debugPrint('API {send notification} - Completed');
    debugPrint(response.body);

    return {
      'status': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };
    // } catch (e) {
    //   return {'error': e.toString()};
    // }
  }
}
