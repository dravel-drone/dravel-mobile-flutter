import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_profile.dart';
import 'package:dravel/pages/profile/page_follow_list.dart';
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

  static Future<ProfileModel?> editProfile(
      AuthController authController,
      {
        required String uid,
        String? imagePath,
        String? name,
        String? oneLiner,
        String? drone,
      }
      ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/profile/$uid');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final request = await http.MultipartRequest('PATCH', url);
      request.headers.addAll(headers);

      if (name != null) {
        request.fields['name'] = name;
      }

      if (oneLiner != null) {
        request.fields['one_liner'] = oneLiner;
      }

      if (drone != null) {
        request.fields['drone'] = drone;
      }

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

        return ProfileModel.fromJson(jsonData);
      }
    }
    return null;
  }

  static Future<List<FollowModel>?> getFollowList(
      AuthController authController,
      bool mode,
      {
        int page = 1,
        int size = 25,
      }) async {
    final Map<String, dynamic> queryParameter = {};
    queryParameter['page'] = page.toString();
    queryParameter['size'] = size.toString();

    final url;
    if (mode == FollowListPage.FOLLOWING_MODE) {
      url = Uri.https(HttpBase.domain, 'api/v1/follow/following', queryParameter);
    } else {
      url = Uri.https(HttpBase.domain, 'api/v1/follow/follower', queryParameter);
    }

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

        List<FollowModel> data = [];
        for (var i in jsonData) {
          data.add(FollowModel.fromJson(i, isFollow: true));
        }

        return data;
      }
    }
    return null;
  }

  static Future<bool?> deleteFollower(
      AuthController authController,
      {
        required String uid,
      }
      ) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/follow/follower/$uid');

    int trial = 0;
    while (trial < 2) {
      final accessKey = await HttpBase.getAccessKey();
      Map<String, String> headers = {};
      if (accessKey != null) {
        headers['Authorization'] = 'Bearer $accessKey';
      }

      final response = await http.delete(url, headers: headers);

      if (response.statusCode != 204) {
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