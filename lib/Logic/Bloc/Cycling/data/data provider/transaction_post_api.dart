library transaction_post_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TransactionPostApi {
  String baseUrl = domain;
  String endPoint = user['/transactions']!;
  TransactionPostApi();

  Future<Map<String, dynamic>> postTransactionData(
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
            "userId": int.parse(reqBody['userId']!.toString()),
            "amount": reqBody['amount']!.toString(),
            "transactionStatusId":
                int.parse(reqBody['transactionStatusId']!.toString())
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
