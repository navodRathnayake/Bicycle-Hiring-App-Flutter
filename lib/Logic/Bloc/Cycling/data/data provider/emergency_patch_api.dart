library emergency_patch_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EmergencyPatchApi {
  String baseUrl = domain;
  String endPoint = emergency['/patch']!;
  EmergencyPatchApi();

  Future<Map<String, dynamic>> emergencyPatch({
    required String bearerToken,
    required String emergencyID,
  }) async {
    String emergencyEndPoint = '$endPoint/$emergencyID';
    debugPrint('PathID ID : $emergencyEndPoint');
    try {
      var url = Uri.http(domain, emergencyEndPoint);

      debugPrint(url.toString());

      var response = await http.patch(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({"emegencyStatusId": 2}));
      debugPrint('API {path - patch} - Completed');
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
