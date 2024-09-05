import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/pages/detail/page_dronespot_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/model_term.dart';

class DroneSpotHttp {
  static Future<List<DroneSpotModel>?> getPopularDronespot(AuthController authController) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/dronespot/popular', {
      'size': '3'
    });
    // final url = Uri.http(HttpBase.debugUrl, 'api/v1/dronespot/popular');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      // debugPrint(url.);
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
          return null;
        }
      } else {
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
    return null;
  }

  static Future<List<DroneSpotModel>?> getAllDronespot(AuthController authController, {
    int? droneType
  }) async {
    final Map<String, dynamic> queryParameter = {};
    if (droneType != null) queryParameter['drone_type'] = '$droneType';
    debugPrint(queryParameter.toString());

    final url = Uri.https(HttpBase.domain, 'api/v1/dronespot/all', queryParameter);
    // final url = Uri.http(HttpBase.debugUrl, 'api/v1/dronespot/popular');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      // debugPrint(url.);
      final response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        if (response.statusCode == 401 && trial == 0) {
          debugPrint("Accesstoken Expired");
          if (!await authController.refreshAccessToken()) {
            return null;
          }
          trial += 1;
          continue;
        } else if (response.statusCode == 404) {
          debugPrint("not found");
          return [];
        } else {
          return null;
        }
      } else {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint(jsonData.toString());

        List<DroneSpotModel> data = [];
        for (var i in jsonData) {
          data.add(DroneSpotModel.fromJson(i));
        }
        return data;
      }
    }
    return null;
  }

  static Future<DronespotDetailModel?> getDronespotDetial(AuthController authController, {
    required int id
  }) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/dronespot/$id');
    // final url = Uri.http(HttpBase.debugUrl, 'api/v1/dronespot/popular');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      // debugPrint(url.);
      final response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          debugPrint("Accesstoken Expired");
          if (!await authController.refreshAccessToken()) {
            debugPrint(utf8.decode(response.bodyBytes));
            return null;
          }
          trial += 1;
          continue;
        } else {
          debugPrint(utf8.decode(response.bodyBytes));
          return null;
        }
      } else {
        debugPrint(utf8.decode(response.bodyBytes));
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint(jsonData.toString());

        return DronespotDetailModel.fromJson(jsonData);
      }
    }
    return null;
  }

  static Future<bool?> likeDronespot(
      AuthController authController,
      {
        required int id,
      }
      ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/like/dronespot/$id');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final response = await http.post(url, headers: headers);

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
        final responseBody = utf8.decode(response.bodyBytes);
        debugPrint(responseBody);

        return true;
      }
    }
    return null;
  }

  static Future<bool?> unlikeDronespot(
      AuthController authController,
      {
        required int id,
      }
      ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/like/dronespot/$id');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final response = await http.delete(url, headers: headers);

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
        final responseBody = utf8.decode(response.bodyBytes);
        debugPrint(responseBody);

        return true;
      }
    }
    return null;
  }
}
