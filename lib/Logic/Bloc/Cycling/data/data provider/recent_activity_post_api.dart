library recent_activity_post_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RecentActivityPostApi {
  String baseUrl = domain;
  String endPoint = postRecentActivity['/recent_activities']!;
  RecentActivityPostApi();

  Future<Map<String, dynamic>> postRecentActivityData(
      {required String bearerToken,
      required Map<String, String> reqBody}) async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());

      var response = await http.post(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({
            "userId": int.parse(reqBody['userID']!.toString()),
            "pathId": int.parse(reqBody['pathID']!.toString()),
            "stationId": int.parse(reqBody['stationID']!.toString()),
            "bicycleId": int.parse(reqBody['bicycleID']!.toString()),
            "paymentTypeId": 1,
            "date": "1985-03-14",
            "startTime": "19:26:22",
            "amount": double.parse(reqBody['amount']!.toString()),
            "endTime": "07:21:50"
          }));
      debugPrint('API {transaction - post} - Completed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      debugPrint(bearerToken);
      return {
        'status': response.statusCode,
        'body': response.body,
        'headers': response.headers
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
