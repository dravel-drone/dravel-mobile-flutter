import 'package:dravel/channel/channel_kakao_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KakaoMapView extends StatelessWidget {
  KakaoMapView({
    required this.channel,
    // required this.initData,
    this.lat = 33.541130,
    this.lon = 126.669621,
    this.zoomLevel = 14,
    this.onLabelTab,
    this.onMapInit
  });

  final KakaoMapChannel channel;

  double lat;
  double lon;
  int zoomLevel;

  // List<Map<String, D>> initData = [];
  
  Function(int id)? onLabelTab;
  Function()? onMapInit;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> creationParams = {
      'lat': lat,
      'lon': lon,
      'zoomLevel': zoomLevel,
      // 'initData': initData
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'map-kakao',
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'map-kakao',
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text('Unsupported platform');
  }

  void _onPlatformViewCreated(int id) {
    channel.initChannel(id);
    channel.channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onLabelTabbed": {
          final args = call.arguments;
          int dataId = args["id"]!;

          if (onLabelTab == null) break;
          onLabelTab!(dataId);
          break;
        }
        case "onMapInit": {
          if (onMapInit != null) onMapInit!();
          break;
        }
      }
    });
  }
}