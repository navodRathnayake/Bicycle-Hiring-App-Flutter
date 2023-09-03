library recent_activity_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/recent_activity_post_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class RecentActivityPostRepository {
  final RecentActivityPostApi api;

  const RecentActivityPostRepository({required this.api});

  Future<Map<String, dynamic>> postRecentActivity(
      {required Map<String, String> reqBody}) async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      var userID = await SqfliteHelper.instance.readUserID();
      debugPrint('USER ID : ${userID['db_id']}');

      final rawResponseData = await api
          .postRecentActivityData(bearerToken: userBearerToken, reqBody: {
        'userID': userID['db_id']!.toString(),
        "pathID": reqBody['pathID']!.toString(),
        "stationID": reqBody['stationID']!.toString(),
        "bicycleID": reqBody['bicycleID']!.toString(),
        "amount": reqBody['amount']!.toString(),
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
