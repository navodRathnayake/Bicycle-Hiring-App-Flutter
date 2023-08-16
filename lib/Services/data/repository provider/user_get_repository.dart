library user_get_repository;

import 'dart:convert' as convert;
import 'package:final_project/Services/data/data%20provider/user_get_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class UserGetRepository {
  final UserGetApi api;

  const UserGetRepository({required this.api});

  Future<Map<String, dynamic>> getUserResponse() async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      var userId = await SqfliteHelper.instance.readUserID();

      debugPrint('User ID : ${userId['db_id'].toString()}');

      final rawResponseData = await api.getUserData(
          bearerToken: userBearerToken, userId: userId['db_id'].toString());
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;
      if (rawResponseData['status'] == 200) {
        debugPrint('AAAAAAAAAAAAAA');
        // var token = response['token'].toString();
        // var message = response['message'].toString();
        // var statusID = response['status id'].toString();

        return {
          'result': 1,
          'body': response,
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
