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

  factory PlaceModel.fromJson(Map<String, dynamic> jsonData) {
    final location = LocationModel(
      lat: jsonData['location']['lat'],
      lon: jsonData['location']['lon'],
      address: jsonData['location']['address'],
    );

    return PlaceModel(
        name: jsonData['name'],
        id: jsonData['id'],
        comment: jsonData['comment'],
        photoUrl: jsonData['photo_url'],
        placeType: jsonData['place_type_id'],
        location: location
    );
  }
}

class DronespotPlaceModel {
  List<PlaceModel> accommodations;
  List<PlaceModel> restaurants;

  DronespotPlaceModel({
    this.accommodations = const [],
    this.restaurants = const []
  });

  factory DronespotPlaceModel.fromJson(Map<String, dynamic> jsonData) {
    final accommodationList = List.generate(jsonData['accommodations'].length, (idx) =>
        PlaceModel.fromJson(jsonData['accommodations'][idx]));

    final restaurantList = List.generate(jsonData['restaurants'].length, (idx) =>
        PlaceModel.fromJson(jsonData['restaurants'][idx]));

    return DronespotPlaceModel(
      accommodations: accommodationList,
      restaurants: restaurantList
    );
  }
}
