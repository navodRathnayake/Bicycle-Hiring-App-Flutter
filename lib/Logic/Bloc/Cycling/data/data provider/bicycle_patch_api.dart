library bicycle_patch_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BicyclePatchApi {
  String baseUrl = domain;
  String endPoint = bicycle['/patch']!;
  BicyclePatchApi();

  Future<Map<String, dynamic>> bicyclePatch(
      {required String bearerToken,
      required String bicycleID,
      required String bicycleStatus}) async {
    String patchEndPoint = '$endPoint/$bicycleID';
    debugPrint('BICYCLE ID : $patchEndPoint');
    try {
      var url = Uri.http(domain, patchEndPoint);

      debugPrint(url.toString());

      var response = await http.patch(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({"statusId": bicycleStatus}));
      debugPrint('API {bicycle - patch} - Completed');
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
