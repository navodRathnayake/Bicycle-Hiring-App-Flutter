// library user_update_patch_api;

// import 'dart:convert';

// import 'package:final_project/Const/API/api_data.dart';
// import 'package:final_project/Services/database/sqlite_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class UserUpdatePatchApi {
//   String baseUrl = domain;
//   String endPoint = user['/updatePatch']!;
//   UserUpdatePatchApi();

//   Future<Map<String, dynamic>> getPatchUpdateApi(
//       {required String bearerToken}) async {
//     try {
//       final userID = await SqfliteHelper.instance.readUserID();
//       final String patchEndPoint = endPoint + userID['db_id'].toString();
//       debugPrint(patchEndPoint);

//       var url = Uri.http(domain, patchEndPoint);

//       debugPrint(url.toString());
//       var response = await http.patch(url,
//           headers: {
//             'Content-type': 'application/vnd.api+json',
//             'Accept': 'application/vnd.api+json',
//             'Authorization': 'Bearer $bearerToken'
//           },
//           body: jsonEncode({'status_id': 2}));
//       debugPrint('API {user patch} - Completed');
//       debugPrint(response.statusCode.toString());
//       debugPrint(response.body);
//       return {
//         'status': response.statusCode,
//         'body': response.body,
//         'headers': response.headers
//       };
//     } catch (e) {
//       return {'error': e.toString()};
//     }
//   }
// }
