class LocationModel {
  double lat;
  double lon;
  String? address;

  LocationModel({
    required this.lat,
    required this.lon,
    this.address,
  });
}

class PermitModel {
  int flight;
  int camera;

  PermitModel({
    required this.flight,
    required this.camera,
  });
}

class AreaModel {
  int id;
  String name;

  AreaModel({
    required this.id,
    required this.name,
  });
}

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