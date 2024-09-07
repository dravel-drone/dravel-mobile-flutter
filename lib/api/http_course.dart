import 'dart:convert';

import 'package:dravel/api/http_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/model_course.dart';

class CourseHttp {
  static Future<CourseModel?> getRecommendCourse() async {
    final url = Uri.https(HttpBase.domain, 'api/v1/trend/course');

    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(jsonData.toString());

    return CourseModel.fromJson(jsonData);
  }

  static Future<CourseModel?> getCourseDetail({
    required int id
  }) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/course/$id');

    final response = await http.get(url);

    if (response.statusCode != 200) return null;

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    debugPrint(jsonData.toString());

    return CourseModel.fromJson(jsonData);
  }
}