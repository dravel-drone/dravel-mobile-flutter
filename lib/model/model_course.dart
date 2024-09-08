import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/model/model_place.dart';

class CourseModel {
  String name;
  String content;
  String? photoUrl;
  int distance;
  int duration;
  int id;

  CourseModel({
    required this.name,
    required this.content,
    required this.distance,
    required this.duration,
    required this.id,
    this.photoUrl
  });

  factory CourseModel.fromJson(Map<String, dynamic> jsonData) {
    return CourseModel(
      name: jsonData['name'],
      content: jsonData['content'],
      distance: jsonData['distance'],
      duration: jsonData['duration'],
      id: jsonData['id'],
      photoUrl: jsonData['photo_url']
    );
  }
}

class CourseDetailModel extends CourseModel {
  List<dynamic> places;

  CourseDetailModel({
    required super.name,
    required super.content,
    required super.distance,
    required super.duration,
    required super.id,
    super.photoUrl,
    this.places = const []
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> places = [];
    for (var place in jsonData['places']) {
      if (place['permit'] != null) {
        places.add(DroneSpotModel.fromJson(place));
      } else {
        places.add(PlaceModel.fromJson(place));
      }
    }

    return CourseDetailModel(
      name: jsonData['name'],
      content: jsonData['content'],
      distance: jsonData['distance'],
      duration: jsonData['duration'],
      id: jsonData['id'],
      photoUrl: jsonData['photo_url'],
      places: places
    );
  }
}