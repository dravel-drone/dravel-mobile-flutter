import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_etc.dart';

class DronespotReviewModel {
  int id;
  SimpleUserModel? writer;
  String placeName;
  PermitModel permit;
  String droneType;
  String drone;
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
    required this.drone,
    required this.date,
    required this.comment,
    required this.photoUrl,
    required this.likeCount,
    required this.isLike
  });
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
