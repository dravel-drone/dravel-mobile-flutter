import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/model_term.dart';

class TermHttp {
  static Future<List<TermModel>?> getAllTermData() async {
    final url = Uri.https(HttpBase.domain, 'api/v1/term');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      return null;
    }
    debugPrint(utf8.decode(response.bodyBytes));
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(jsonData.toString());

    List<TermModel> data = [];
    for (var i in jsonData) {
      data.add(TermModel.fromJson(i));
    }
    return data;
  }
}
