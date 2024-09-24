import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_review.dart';
import 'package:dravel/model/model_etc.dart';
import 'package:dravel/model/model_place.dart';

import 'model_course.dart';

class DroneSpotModel {
  int id;
  String name;
  LocationModel location;
  String comment;
  PermitModel permit;
  bool isLike;
  int likeCount;
  int reviewCount;
  String? imageUrl;
  List<AreaModel> area;

  DroneSpotModel({
    required this.id,
    required this.name,
    required this.location,
    required this.comment,
    required this.permit,
    required this.isLike,
    required this.likeCount,
    required this.reviewCount,
    this.imageUrl,
    this.area = const [],
  });

  factory DroneSpotModel.fromJson(Map<String, dynamic> data) {
    final location = LocationModel(
      lat: data['location']['lat'],
      lon: data['location']['lon'],
      address: data['location']['address'],
    );
    final permit = PermitModel(
      flight: data['permit']['flight'],
      camera: data['permit']['camera']
    );
    final areaList = List.generate(data['area'].length, (idx) => AreaModel(
        id: data['area'][idx]['id'],
        name: data['area'][idx]['name']
      )
    );

    return DroneSpotModel(
      id: data['id'],
      name: data['name'],
      location: location,
      comment: data['comment'],
      permit: permit,
      isLike: data['is_like'] == 1,
      likeCount: data['likes_count'] ?? 0,
      reviewCount: data['reviews_count'] ?? 0,
      imageUrl: data['photo'],
      area: areaList,
    );
  }
}

class DronespotDetailModel extends DroneSpotModel {
  List<DronespotReviewDetailModel> reviews;
  DronespotPlaceModel places;
  List<CourseModel> courses;
  WhetherModel? whether;

  DronespotDetailModel({
    required super.id,
    required super.name,
    required super.location,
    required super.comment,
    required super.permit,
    required super.isLike,
    required super.likeCount,
    required super.reviewCount,
    super.imageUrl,
    super.area = const [],

    this.reviews = const [],
    this.courses = const [],
    this.whether,
    required this.places,
  });

  factory DronespotDetailModel.fromJson(Map<String, dynamic> jsonData) {
    final location = LocationModel(
      lat: jsonData['location']['lat'],
      lon: jsonData['location']['lon'],
      address: jsonData['location']['address'],
    );
    final permit = PermitModel(
        flight: jsonData['permit']['flight'],
        camera: jsonData['permit']['camera']
    );
    final areaList = List.generate(jsonData['area'].length, (idx) => AreaModel(
        id: jsonData['area'][idx]['id'],
        name: jsonData['area'][idx]['name']
      )
    );

    final reviewList = List.generate(jsonData['reviews'].length, (idx) {
      final writer = jsonData['reviews'][idx]['writer'] != null ? SimpleUserModel(
          uid: jsonData['reviews'][idx]['writer']['uid'],
          name: jsonData['reviews'][idx]['writer']['name']
      ) : null;
      final reviewPermit = PermitModel(
          flight: jsonData['reviews'][idx]['permit']['flight'],
          camera: jsonData['reviews'][idx]['permit']['camera']
      );

      return DronespotReviewDetailModel(
          id: jsonData['reviews'][idx]['id'],
          writer: writer,
          placeName: jsonData['reviews'][idx]['place_name'],
          permit: reviewPermit,
          droneType: jsonData['reviews'][idx]['drone_type'],
          drone: jsonData['reviews'][idx]['drone'],
          date: jsonData['reviews'][idx]['date'].split('T')[0],
          comment: jsonData['reviews'][idx]['comment'],
          photoUrl: jsonData['reviews'][idx]['photo'],
          likeCount: jsonData['reviews'][idx]['like_count'] ?? 0,
          isLike: jsonData['reviews'][idx]['is_like'] == 1
      );
    });

    final courseList = List.generate(jsonData['courses'].length, (idx) {
      return CourseModel(
        name: jsonData['courses'][idx]['name'],
        content: jsonData['courses'][idx]['content'],
        distance: jsonData['courses'][idx]['distance'],
        duration: jsonData['courses'][idx]['duration'],
        id: jsonData['courses'][idx]['id'],
        photoUrl: jsonData['courses'][idx]['photo_url']
      );
    });

    WhetherModel? whether;
    if (jsonData['whether'] != null) {
      whether = WhetherModel.fromJson(jsonData['whether']);
    }

    return DronespotDetailModel(
      id: jsonData['id'],
      name: jsonData['name'],
      whether: whether,
      isLike: jsonData['is_like'] == 1,
      likeCount: jsonData['likes_count'] ?? 0,
      reviewCount: jsonData['reviews_count'] ?? 0,
      imageUrl: jsonData['photo_url'],
      comment: jsonData['comment'],
      location: location,
      area: areaList,
      permit: permit,
      reviews: reviewList,
      courses: courseList,
      places: DronespotPlaceModel.fromJson(jsonData['places'])
    );
  }
}

class TrendDronrspot {
  String name;
  int id;

  TrendDronrspot({
    required this.name,
    required this.id
  });
}
