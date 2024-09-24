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

class WhetherModel {
  int temp;
  int sky;
  int pty;

  WhetherModel({
    required this.temp,
    required this.sky,
    required this.pty,
  });

  factory WhetherModel.fromJson(Map<String, dynamic> data) {
    return WhetherModel(
      temp: data['tmp'],
      sky: data['sky'],
      pty: data['pty'],
    );
  }
}