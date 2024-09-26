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
          debugPrint(await response.stream.bytesToString());
          return null;
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        debugPrint(responseBody);
        final jsonData = jsonDecode(responseBody);
        debugPrint(jsonData.toString());

        return DronespotReviewModel.fromJson(jsonData);
      }
    }
    return null;
  }

  static Future<bool?> likeReview(
    AuthController authController,
    {
      required int id,
    }
  ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/like/review/$id');

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

  static Future<bool?> unlikeReview(
    AuthController authController,
    {
      required int id,
    }
  ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/like/review/$id');

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

  static Future<int?> reportReview(
    AuthController authController,
    {
      required int id,
    }
  ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/review/report/$id');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final response = await http.post(url, headers: headers);

      if (response.statusCode != 204) {
        if (response.statusCode == 401 && trial == 0) {
          debugPrint("Accesstoken Expired");
          if (!await authController.refreshAccessToken()) {
            return null;
          }
          trial += 1;
          continue;
        } else if (response.statusCode == 400) {
          return 0;
        } else {
          debugPrint(utf8.decode(response.bodyBytes));
          return null;
        }
      } else {
        final responseBody = utf8.decode(response.bodyBytes);
        debugPrint(responseBody);

        return 1;
      }
    }
    return null;
  }

  static Future<List<DronespotReviewModel>?> getTrendReview(
    AuthController authController,
  ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/trend/review');

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

        List<DronespotReviewModel> data = [];
        for (var i in jsonData) {
          data.add(DronespotReviewModel.fromJson(i));
        }

        return data;
      }
    }
    return null;
  }

  static Future<List<DronespotReviewDetailModel>?> getLikeReview(
    AuthController authController,
  ) async {

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }
      final url = Uri.https(HttpBase.domain, 'api/v1/review/like/${authController.userUid.value}');

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

        List<DronespotReviewDetailModel> data = [];
        for (var i in jsonData) {
          data.add(DronespotReviewDetailModel.fromJson(i));
        }

        return data;
      }
    }
    return null;
  }

  static Future<List<DronespotReviewDetailModel>?> getUserReview(
    AuthController authController, {
      int page = 1,
      int size = 25,
      required String uid
  }) async {
    final Map<String, dynamic> queryParameter = {};
    queryParameter['page_num'] = page.toString();
    queryParameter['size'] = size.toString();

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }
      final url = Uri.https(HttpBase.domain, 'api/v1/userReview/$uid', queryParameter);

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

        List<DronespotReviewDetailModel> data = [];
        for (var i in jsonData) {
          data.add(DronespotReviewDetailModel.fromJson(i));
        }

        return data;
      }
    }
    return null;
  }

  static Future<List<DronespotReviewDetailModel>?> getDronespotReview(
    AuthController authController, {
      int page = 1,
      int size = 25,
      required int id
  }) async {
    final Map<String, dynamic> queryParameter = {};
    queryParameter['page_num'] = page.toString();
    queryParameter['size'] = size.toString();

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }
      final url = Uri.https(HttpBase.domain, 'api/v1/spotReview/$id', queryParameter);

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

        List<DronespotReviewDetailModel> data = [];
        for (var i in jsonData) {
          data.add(DronespotReviewDetailModel.fromJson(i));
        }

        return data;
      }
    }
    return null;
  }
}
