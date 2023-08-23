library validate_bicycle_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/validate_bicycle_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';

class ValidateBicycleRepository {
  final String bicycleID;
  final ValidateBicycleApi api;
  const ValidateBicycleRepository({required this.api, required this.bicycleID});

  Future<Map<String, dynamic>> getBicycleResponse() async {
    try {
      var userBearerToken = await SqfliteHelper.instance.readBearerToken();
      debugPrint(userBearerToken.toString());

      final rawResponseData = await api.getBicycleData(
          bearerToken: userBearerToken, bicycleID: bicycleID);
      final response =
          convert.jsonDecode(rawResponseData['body']) as Map<String, dynamic>;
      debugPrint('Hellooooooooo');
      if (rawResponseData['status'] == 200) {
        debugPrint('AAAAAAAAAAAAAA');

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
