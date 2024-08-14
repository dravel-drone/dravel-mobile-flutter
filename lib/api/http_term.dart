import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:http/http.dart' as http;

import '../model/model_term.dart';

class TermHttp {
  static Future<TermModel> getAllTermData() async {
    final url = Uri.https(HttpBase.domain, 'api/v1/term');
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    return TermModel.fromJson(jsonData);
  }
}
