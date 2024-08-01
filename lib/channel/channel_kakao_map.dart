import 'package:flutter/services.dart';

class KakaoMapChannel {
  late final MethodChannel _channel;

  void initChannel(int id) {
    _channel = MethodChannel('map-kakao/$id');
  }

  Future<void> moveCamera({
    required double lat,
    required double lon,
    required int zoomLevel,
  }) async {
    await _channel.invokeMethod('moveCamera', {
      'lat': lat,
      'lon': lon,
      'zoomLevel': zoomLevel
    });
  }

  Future<void> addSpotLabel({
    required double lat,
    required double lon,
    required String name,
    required int id,
  }) async {
    await _channel.invokeMethod('addSpotLabel', {
      'lat': lat,
      'lon': lon,
      'name': name,
      'id': id
    });
  }
}