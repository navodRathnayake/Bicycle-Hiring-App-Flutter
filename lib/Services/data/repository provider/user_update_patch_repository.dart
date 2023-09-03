library user_update_patch_repository;

import 'package:final_project/Services/data/data%20provider/user_update_patch_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;

class UserUpdatePatchRepository {
  final UserUpdatePatchApi api;

  const UserUpdatePatchRepository({required this.api});

  Future<Map<String, dynamic>> getPatchUpdateRepository(
      {required Map<String, String> reqBody}) async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      final rawResponseData = await api.getPatchUpdateApi(
          bearerToken: userBearerToken, reqBody: reqBody);
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;
      if (rawResponseData['status'] == 200) {
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
