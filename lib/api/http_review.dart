import 'dart:convert';
import 'dart:io';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/model/model_review.dart';
import 'package:dravel/pages/detail/page_dronespot_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/model_term.dart';

class ReviewHttp {
  static Future<DronespotReviewModel?> addReview(
    AuthController authController,
    {
      required int id,
      required DronespotReviewCreateModel data,
      String? imagePath
    }
  ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/review/$id');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final request = await http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      request.fields['comment'] = data.comment;
      request.fields['drone_type'] = data.droneType;
      request.fields['date'] = data.date;
      request.fields['drone'] = data.drone;
      request.fields['permit_flight'] = '${data.permitFlight}';
      request.fields['permit_camera'] = '${data.permitCamera}';

      if (imagePath != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'file', imagePath
        ));
      }

      final response = await request.send();

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
        debugPrint(await response.stream.bytesToString());
        final jsonData = jsonDecode(await response.stream.bytesToString());
        debugPrint(jsonData.toString());

        return DronespotReviewModel.fromJson(jsonData);
      }
    }
    return null;
  }
}
