library login_form_repository;

import '../data provider/login_form_api.dart';
import 'dart:convert' as convert;

class LoginFormRepository {
  final LoginFormApi api;

  const LoginFormRepository({required this.api});

  Future<Map<String, dynamic>> getLoginResponse() async {
    try {
      final rawResponseData = await api.getLoginRawData();
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;
      if (rawResponseData['status code'] == 200) {
        var token = response['token'].toString();
        var message = response['message'].toString();
        var statusID = response['statusId'].toString();
        var userID = response['userId'].toString();

        return {
          'result': 1,
          'status code': rawResponseData['status code'].toString(),
          'body': {
            'status id': statusID.toString(),
            'userID': userID,
            'token': token,
            'message': message,
          },
        };
      } else {
        return {
          'result': 0,
          'error': response['status'],
        };
      }
    } catch (e) {
      return {
        'result': 0,
        'error': e.toString(),
      };
    }
  }
}
