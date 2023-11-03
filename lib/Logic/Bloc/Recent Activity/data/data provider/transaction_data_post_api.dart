library transaction_data_post_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionDataPostApi {
  String baseUrl = domain;
  // String endPoint = user['/updatePatch']!;
  TransactionDataPostApi();

  Future<Map<String, dynamic>> getPatchUpdateApi(
      {required String bearerToken, required String amount}) async {
    try {
      final userID = await SqfliteHelper.instance.readUserID();
      // final String patchEndPoint = endPoint + userID['db_id'].toString();
      // debugPrint(patchEndPoint);

      var url = Uri.http(domain, '/api/v1/transactions');

      debugPrint(url.toString());
      var response = await http.post(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({
            "userId": int.parse(userID['db_id'].toString()),
            "amount": "amount",
            "transactionStatusId": 1
          }));
      debugPrint('API {transaction post} - Completed');
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
