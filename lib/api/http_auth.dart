import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthHttp {
  static String? _extractToken(String input, String tokenType) {
    final regex = RegExp('${tokenType}=([^;]+)');
    final match = regex.firstMatch(input);
    return match != null ? match.group(1) : null;
  }

  static Future<bool> registerUser(RegisterModel inputModel) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/register');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(inputModel.toJson()));
    if (response.statusCode != 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      return false;
    }
    return true;
  }

  static Future<Map<String, dynamic>?> login(LoginModel loginModel) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/login');
    // final url = Uri.http(HttpBase.debugUrl, 'api/v1/login');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginModel.toJson()));
    if (response.statusCode != 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      return null;
    }

    final cookies = response.headers['set-cookie']!;
    final accessToken = _extractToken(cookies, 'access_token');
    final refreshToken = _extractToken(cookies, 'refresh_token');

    debugPrint("access_token: $accessToken\nrefresh_token: $refreshToken");
    debugPrint(utf8.decode(response.bodyBytes));
    return {
      'key': AuthKeyModel(
          accessKey: accessToken!,
          refreshKey: refreshToken!
      ),
      'user': LoginUserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
    };
  }

  static Future<bool> logout(LogoutModel logoutModel) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/logout');
    // final url = Uri.http(HttpBase.debugUrl, 'api/v1/logout');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(logoutModel.toJson()));
    if (response.statusCode != 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      return false;
    }
    return true;
  }

  static Future<String?> refresh(RefreshModel refreshModel, {
    required String refreshToken
  }) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/refresh');
    // final url = Uri.http(HttpBase.debugUrl, 'api/v1/refresh');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Cookie': 'refresh_token=$refreshToken'
        },
        body: jsonEncode(refreshModel.toJson()));
    if (response.statusCode != 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      return null;
    }

    final cookies = response.headers['set-cookie']!;
    final accessToken = _extractToken(cookies, 'access_token');
    return accessToken;
  }
}
