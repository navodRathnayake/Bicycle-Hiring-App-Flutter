library path_post_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/path_post_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class PathPostRepository {
  final PathPostApi api;

  const PathPostRepository({required this.api});

  Future<Map<String, dynamic>> postPath(
      {required Map<String, dynamic> reqBody}) async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      var userID = await SqfliteHelper.instance.readUserID();
      debugPrint('USER ID : ${userID['db_id']}');

      final rawResponseData =
          await api.postPath(bearerToken: userBearerToken, reqBody: {
        "user_id": userID['db_id'].toString(),
        "bicycleId": reqBody['bicycleId'].toString(),
        "startLong": reqBody['startLong'].toString(),
        "startLang": reqBody['startLang'].toString(),
        "startLocation": reqBody['startLocation'],
      });
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
