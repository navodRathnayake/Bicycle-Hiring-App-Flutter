library gps_get_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GPSGetApi {
  String baseUrl = domain;
  String endPoint = user['/recentActivity']!;
  GPSGetApi();

  Future<Map<String, dynamic>> getGPS(
      {required String bearerToken, required int pathID}) async {
    try {
      String endPointUrl = "/api/v1/paths/$pathID/gps";
      debugPrint(endPointUrl);
      var url = Uri.http(domain, endPointUrl);

      debugPrint(url.toString());
      var response = await http.get(
        url,
        headers: {
          'Content-type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $bearerToken'
        },
      );
      debugPrint('API {gps} - Completed');
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
