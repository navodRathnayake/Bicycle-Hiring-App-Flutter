library logout_requested_repository;

import 'dart:convert' as convert;
import 'package:final_project/Logic/Bloc/Login/auth/logout/data/data%20provider/logout_request_api.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';

class LogoutRequestedRepository {
  final LogoutRequestedApi api;
  const LogoutRequestedRepository({required this.api});

  Future<Map<String, dynamic>> getRegisterResponse() async {
    var userBearerToken = await SqfliteHelper.instance.readBearerToken();
    // try {
    final rawResponse =
        await api.getLogoutRawData(bearerToken: userBearerToken);
    final response =
        await convert.jsonDecode(rawResponse['body']) as Map<String, dynamic>;
    debugPrint('Log Out Decoded');
    debugPrint(rawResponse['status'].toString());
    debugPrint(rawResponse['status'].runtimeType.toString());
    if (rawResponse['status'] == 200) {
      debugPrint('success');

      return {
        'result': 1,
      };
    } else {
      debugPrint('ksldask');
      return {
        'result': 0,
        'error': rawResponse['status code'],
      };
    }
  }
}
