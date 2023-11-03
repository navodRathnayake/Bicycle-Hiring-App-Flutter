library user_account_get_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserAccountGetApi {
  UserAccountGetApi();

  Future<Map<String, dynamic>> getUserAccount({
    required String bearerToken,
    required String userID,
  }) async {
    try {
      debugPrint(userID);
      String recentActivityEndpoint = '/api/v1/users/$userID';
      var url = Uri.http(domain, recentActivityEndpoint);

      debugPrint(url.toString());
      var response = await http.get(url, headers: {
        'Content-type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
        'Authorization': 'Bearer $bearerToken'
      });

      debugPrint('API {User get} - Completed');
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
