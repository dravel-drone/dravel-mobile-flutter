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