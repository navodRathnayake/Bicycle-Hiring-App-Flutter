library emergency_post_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/emergency_post_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class EmergencyPostRepository {
  final EmergencyPostApi api;

  const EmergencyPostRepository({required this.api});

  Future<Map<String, dynamic>> postEmergency(
      {required Map<String, dynamic> reqBody}) async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      var userID = await SqfliteHelper.instance.readUserID();
      debugPrint('USER ID : ${userID['db_id']}');

      final rawResponseData =
          await api.emergencyPost(bearerToken: userBearerToken, reqBody: {
        "bicycleID": reqBody['bicycleID']!.toString(),
        "emergencyStatusID": reqBody['emergencyStatusID']!.toString(),
        "lang": reqBody['lang']!.toString(),
        "long": reqBody['long']!.toString(),
        "date": reqBody['date']!.toString(),
        "time": reqBody['time']!.toString(),
        "description": reqBody['description']!.toString()
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
