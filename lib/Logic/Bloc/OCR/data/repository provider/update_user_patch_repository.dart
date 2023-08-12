library update_user_patch_repository;

import 'package:final_project/Logic/Bloc/OCR/data/data%20provider/update_user_patch_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;

class UpdateUserPatchRepository {
  final Map<String, String> reqBody;
  final UpdateUserPatchApi api;

  const UpdateUserPatchRepository({required this.api, required this.reqBody});

  Future<Map<String, dynamic>> getPatchUpdateRepository() async {
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
