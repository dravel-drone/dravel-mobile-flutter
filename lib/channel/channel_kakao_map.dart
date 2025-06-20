import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:flutter/services.dart';

class KakaoMapChannel {
  late MethodChannel _channel;

  void initChannel(int id) {
    _channel = MethodChannel('map-kakao/$id');
  }

  MethodChannel get channel => _channel;

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

  Future<void> removeAllSpotLabel() async {
    await _channel.invokeMethod('removeAllSpotLabel');
  }

  Future<void> setLabels(List<dynamic> data) async {
    await _channel.invokeMethod('setLabels', {
      'labels': data
    });
  }
}