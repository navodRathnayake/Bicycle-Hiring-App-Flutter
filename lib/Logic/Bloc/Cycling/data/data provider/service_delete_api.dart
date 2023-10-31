library service_delete_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ServiceDeleteApi {
  String baseUrl = domain;
  String endPoint = service['/delete']!;
  ServiceDeleteApi();

  Future<Map<String, dynamic>> deleteService(
      {required String bicycleID}) async {
    try {
      debugPrint('API works');
      debugPrint('Bicycle ID : {$bicycleID}');
      String deletionEndPoint = "$endPoint/$bicycleID";
      debugPrint(deletionEndPoint);
      var url = Uri.http(domain, deletionEndPoint);

      debugPrint(url.toString());

      var response = await http.delete(url, headers: {
        'Content-type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
      });

      debugPrint('API {service - delete} - Completed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
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
