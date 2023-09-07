library path_patch_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PathPatchApi {
  String baseUrl = domain;
  String endPoint = path['/path']!;
  PathPatchApi();

  Future<Map<String, dynamic>> pathPatch(
      {required String bearerToken,
      required String pathID,
      required Map<String, String> reqBody}) async {
    String patchEndPoint = '$endPoint/$pathID';
    debugPrint('PathID ID : $patchEndPoint');
    try {
      var url = Uri.http(domain, patchEndPoint);

      debugPrint(url.toString());

      var response = await http.patch(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({
            "endLang": reqBody['endLang']!,
            "endLong": reqBody['endLong']!,
            "endLocation": reqBody['endLocation']!,
            'distance': reqBody['distance']!
          }));
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
