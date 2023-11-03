library user_patch_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPatchAPI {
  String baseUrl = domain;
  String endPoint = user['/recentActivity']!;
  UserPatchAPI();

  Future<Map<String, dynamic>> patchUserAPI(
      {required String bearerToken,
      required String userID,
      required String points}) async {
    try {
      debugPrint(userID);
      String recentActivityEndpoint = '/api/v1/users/$userID';
      var url = Uri.http(domain, recentActivityEndpoint);

      debugPrint(url.toString());
      var response = await http.patch(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({'points': points}));

      debugPrint('API {User Patch} - Completed');
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
