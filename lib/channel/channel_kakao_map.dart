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
}