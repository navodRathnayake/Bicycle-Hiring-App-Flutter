library recent_activity_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentActivityApi {
  String baseUrl = domain;
  String endPoint = user['/recentActivity']!;
  RecentActivityApi();

  Future<Map<String, dynamic>> getRecentActivity(
      {required String bearerToken}) async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());
      var response = await http.get(
        url,
        headers: {
          'Content-type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $bearerToken'
        },
      );
      debugPrint('API {recent Activity} - Completed');
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
