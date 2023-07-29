library register_repository;

import 'dart:convert' as convert;
import 'package:flutter/material.dart';

import '../data provider/register_api.dart';

class RegisterRepository {
  final RegisterApi api;
  const RegisterRepository({required this.api});

  Future<Map<String, dynamic>> getRegisterResponse() async {
    try {
      final rawResponse = await api.getRegisterRawData();
      final response =
          await convert.jsonDecode(rawResponse['body']) as Map<String, dynamic>;
      if (rawResponse['status'] == 200) {
        var token = response['data']['token'].toString();
        var email = response['data']['user']['email'].toString();
        var name = response['data']['user']['name'].toString();
        var id = response['data']['user']['id'].toString();
        var msg = response['message'].toString();

        return {
          'result': 1,
          'body': {
            'token': token,
            'email': email,
            'name': name,
            'id': id,
            'message': msg,
          },
        };
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
