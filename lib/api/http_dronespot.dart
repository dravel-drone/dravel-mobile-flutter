import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/model_term.dart';

class DroneSpotHttp {
  static Future<List<DroneSpotModel>?> getPopularDronespot() async {
    final url = Uri.https(HttpBase.domain, 'api/v1/dronespot/popular');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      return null;
    }
    debugPrint(utf8.decode(response.bodyBytes));
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(jsonData.toString());

    List<DroneSpotModel> data = [];
    for (var i in jsonData) {
      data.add(DroneSpotModel.fromJson(i));
    }
    return data;
  }
}
