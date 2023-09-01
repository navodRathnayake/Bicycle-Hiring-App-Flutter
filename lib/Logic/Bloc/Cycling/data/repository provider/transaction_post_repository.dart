library transaction_post_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/transaction_post_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class TransactionPostRepository {
  final TransactionPostApi api;

  const TransactionPostRepository({required this.api});

  Future<Map<String, dynamic>> postTransaction(
      {required String amount, required String transactionType}) async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      var userID = await SqfliteHelper.instance.readUserID();
      debugPrint('USER ID : ${userID['db_id']}');

      final rawResponseData =
          await api.postTransactionData(bearerToken: userBearerToken, reqBody: {
        'userId': userID['db_id']!.toString(),
        'amount': amount,
        'transactionStatusId': transactionType
      });
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;

      if (rawResponseData['status'] == 200) {
        debugPrint('AAAAAAAAAAAAAA');
        // var token = response['token'].toString();
        // var message = response['message'].toString();
        // var statusID = response['status id'].toString();

        return {
          'result': 1,
          'body': response,
        };
      } else {
        return {
          'result': 0,
          'error': response['status'],
        };
      }
    } catch (e) {
      return {
        'result': 0,
        'error': e.toString(),
      };
    }
  }
}
