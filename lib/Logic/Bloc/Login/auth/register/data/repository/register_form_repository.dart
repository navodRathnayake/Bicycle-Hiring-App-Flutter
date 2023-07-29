library register_form_repository;

import 'dart:convert' as convert;
import 'package:flutter/material.dart';

import '../data provider/register_form_api.dart';

class RegisterFormRepository {
  final RegisterFormApi api;
  const RegisterFormRepository({required this.api});

  Future<Map<String, dynamic>> getRegisterResponse() async {
    try {
      final rawResponse = await api.getRegisterRawData();
      final response =
          await convert.jsonDecode(rawResponse['body']) as Map<String, dynamic>;
      if (rawResponse['status'] == 200) {
        var token = response['token'].toString();
        var msg = response['success'].toString();

        debugPrint(response.toString());

        return {
          'result': 1,
          'body': {
            'token': token,
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
