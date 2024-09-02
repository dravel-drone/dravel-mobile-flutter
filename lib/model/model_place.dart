import 'package:dravel/model/model_etc.dart';

class PlaceModel {
  String name;
  String? comment;
  String? photoUrl;
  LocationModel location;
  int? placeType;
  int id;

  PlaceModel({
    required this.name,
    required this.location,
    required this.id,
    this.comment,
    this.photoUrl,
    this.placeType
  });
}

class DronespotPlaceModel {
  List<PlaceModel> accommodations;
  List<PlaceModel> restaurants;

  DronespotPlaceModel({
    this.accommodations = const [],
    this.restaurants = const []
  });

  factory DronespotPlaceModel.fromJson(Map<String, dynamic> jsonData) {
    final accommodationList = List.generate(jsonData['accommodations'].length, (idx) {
      final location = LocationModel(
        lat: jsonData['accommodations'][idx]['lat'],
        lon: jsonData['accommodations'][idx]['lon'],
        address: jsonData['accommodations'][idx]['address'],
      );

      return PlaceModel(
        name: jsonData['accommodations'][idx]['name'],
        id: jsonData['accommodations'][idx]['id'],
        comment: jsonData['accommodations'][idx]['comment'],
        photoUrl: jsonData['accommodations'][idx]['photo_url'],
        placeType: jsonData['accommodations'][idx]['place_type_id'],
        location: location
      );
    });
    final restaurantList = List.generate(jsonData['restaurants'].length, (idx) {
      final location = LocationModel(
        lat: jsonData['restaurants'][idx]['lat'],
        lon: jsonData['restaurants'][idx]['lon'],
        address: jsonData['restaurants'][idx]['address'],
      );

      return PlaceModel(
        name: jsonData['restaurants'][idx]['name'],
        id: jsonData['restaurants'][idx]['id'],
        comment: jsonData['restaurants'][idx]['comment'],
        photoUrl: jsonData['restaurants'][idx]['photo_url'],
        placeType: jsonData['restaurants'][idx]['place_type_id'],
        location: location
      );
    });

    return DronespotPlaceModel(
      accommodations: accommodationList,
      restaurants: restaurantList
    );
  }
}
