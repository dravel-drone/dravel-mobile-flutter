import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_etc.dart';

class DronespotReviewModel {
  int id;
  SimpleUserModel? writer;
  String placeName;
  PermitModel permit;
  String droneType;
  String date;
  String comment;
  String? photoUrl;
  int likeCount;
  bool isLike;

  DronespotReviewModel({
    required this.id,
    this.writer,
    required this.placeName,
    required this.permit,
    required this.droneType,
    required this.date,
    required this.comment,
    required this.photoUrl,
    required this.likeCount,
    required this.isLike
  });

  factory DronespotReviewModel.fromJson(Map<String, dynamic> jsonData) {
    final writer = jsonData['writer'] != null ? SimpleUserModel(
      uid: jsonData['writer']['uid'],
      name: jsonData['writer']['name']
    ) : null;
    final permit = PermitModel(
      flight: jsonData['permit']['flight'],
      camera: jsonData['permit']['camera']
    );

    return DronespotReviewModel(
      id: jsonData['id'],
      writer: writer,
      placeName: jsonData['place_name'],
      permit: permit,
      droneType: jsonData['drone_type'],
      comment: jsonData['comment'],
      date: jsonData['date'].split('T')[0],
      photoUrl: jsonData['photo'],
      likeCount: jsonData['like_count'],
      isLike: jsonData['is_like'] == 1,
    );
  }
}

class DronespotReviewDetailModel extends DronespotReviewModel {
  String drone;

  DronespotReviewDetailModel({
    required super.id,
    super.writer,
    required super.placeName,
    required super.permit,
    required super.droneType,
    required this.drone,
    required super.date,
    required super.comment,
    required super.photoUrl,
    required super.likeCount,
    required super.isLike
  });

  factory DronespotReviewDetailModel.fromJson(Map<String, dynamic> jsonData) {
    final writer = jsonData['writer'] != null ? SimpleUserModel(
      uid: jsonData['writer']['uid'],
      name: jsonData['writer']['name']
    ) : null;
    final permit = PermitModel(
      flight: jsonData['permit']['flight'],
      camera: jsonData['permit']['camera']
    );

    return DronespotReviewDetailModel(
      id: jsonData['id'],
      writer: writer,
      placeName: jsonData['place_name'],
      permit: permit,
      droneType: jsonData['drone_type'],
      drone: jsonData['drone'],
      comment: jsonData['comment'],
      date: jsonData['date'].split('T')[0],
      photoUrl: jsonData['photo'],
      likeCount: jsonData['like_count'],
      isLike: jsonData['is_like'] == 1,
    );
  }
}

class DronespotReviewCreateModel {
  int permitFlight;
  int permitCamera;
  String droneType;
  String drone;
  String date;
  String comment;

  DronespotReviewCreateModel({
    required this.droneType,
    required this.drone,
    required this.date,
    required this.comment,
    required this.permitFlight,
    required this.permitCamera,
  });
}
