import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProfileHttp {
  static Future<ProfileModel?> getUserProfile(
      AuthController authController,
      {
        required String uid,
      }) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/profile/$uid');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        if (response.statusCode == 401 && trial == 0) {
          debugPrint("Accesstoken Expired");
          if (!await authController.refreshAccessToken()) {
            return null;
          }
          trial += 1;
          continue;
        } else {
          debugPrint(utf8.decode(response.bodyBytes));
          return null;
        }
      } else {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint(jsonData.toString());

        return ProfileModel.fromJson(jsonData);
      }
    }
    return null;
  }
}