import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? positionStream;

  Rx<bool> serviceEnabled = Rx(false);
  Rxn<Position> position = Rxn(null);

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = false;
      debugPrint('GPS Permission Deny');
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        this.serviceEnabled.value = false;
        debugPrint('GPS Permission Deny');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      this.serviceEnabled.value = false;
      debugPrint('GPS Permission Deny');
      return false;
    }

    this.serviceEnabled.value = true;
    debugPrint('GPS Permission Allow');
    return true;
  }

  Future<void> initLocation() async {
    await checkPermission();

    if (!serviceEnabled.value) return;

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
      debugPrint('Location: ' + (position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}'));
      this.position.value = position;
      this.position.refresh();
    });
  }

  @override
  void onClose() {
    if (positionStream != null) positionStream!.cancel();
    super.onClose();
  }
}