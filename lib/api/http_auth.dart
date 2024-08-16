import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthHttp {
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

  static Future<bool> login(LoginModel loginModel) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/register');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginModel.toJson()));
    if (response.statusCode != 200) {
      debugPrint(utf8.decode(response.bodyBytes));
      return false;
    }
    return true;
  }
}
