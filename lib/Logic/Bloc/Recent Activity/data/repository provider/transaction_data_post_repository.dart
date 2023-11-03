library transaction_data_post_repository;

import 'package:final_project/Logic/Bloc/OCR/data/data%20provider/update_user_patch_api.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/data%20provider/transaction_data_post_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;

class TransactionDataPostRepository {
  final TransactionDataPostApi api;

  const TransactionDataPostRepository({required this.api});

  Future<Map<String, dynamic>> postTransactionData(
      {required String amount}) async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      final rawResponseData = await api.getPatchUpdateApi(
          bearerToken: userBearerToken, amount: amount);
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;
      if (rawResponseData['status'] == 200) {
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
