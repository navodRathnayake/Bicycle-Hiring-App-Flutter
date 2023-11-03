library user_account_get_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/data%20provider/user_account_get_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class UserAccountGetRepository {
  final UserAccountGetApi api;

  const UserAccountGetRepository({required this.api});

  Future<Map<String, dynamic>> getUserData() async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      var userID = await SqfliteHelper.instance.readUserID();

      final rawResponseData = await api.getUserAccount(
          bearerToken: userBearerToken, userID: userID['db_id'].toString());
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;
      debugPrint('Hellooooooooo');
      if (rawResponseData['status'] == 200) {
        debugPrint('------------------User Patch --------------------');
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
