import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Rx<bool> serviceEnabled = Rx(false);

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = false;
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        serviceEnabled = false;
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      serviceEnabled = false;
      return false;
    }

    serviceEnabled = true;
    return true;
  }
}