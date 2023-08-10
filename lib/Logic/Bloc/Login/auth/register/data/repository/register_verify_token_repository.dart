library register_verify_token_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Login/auth/register/data/data%20provider/register_verify_token_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';

class RegisterVerifyTokenRepository {
  final RegisterVerifyTokenApi api;
  const RegisterVerifyTokenRepository({required this.api});

  Future<Map<String, dynamic>> getRegisterResponse() async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      final rawResponse =
          await api.getRegisterRawData(bearerToken: userBearerToken);
      final response =
          await convert.jsonDecode(rawResponse['body']) as Map<String, dynamic>;
      if (rawResponse['status'] == 200) {
        debugPrint(response.toString());
        // login state
        return {
          'result': 1,
          'userId': response['userId'],
          'error': rawResponse['status code'],
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
