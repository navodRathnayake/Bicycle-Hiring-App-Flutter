library service_post_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/service_post_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class ServicePostRepository {
  final ServicePostApi api;

  const ServicePostRepository({required this.api});

  Future<Map<String, dynamic>> postService(
      {required Map<String, dynamic> reqBody}) async {
    try {
      var userID = await SqfliteHelper.instance.readUserID();
      debugPrint('USER ID : ${userID['db_id']}');

      final rawResponseData = await api.postService(reqBody: {
        "bicycleID": reqBody['bicycleID'].toString(),
        "pathID": reqBody['pathID'].toString(),
        "recentActivityID": reqBody['recentActivityID'].toString(),
        "userID": userID['db_id'].toString()
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
