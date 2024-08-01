import 'package:dravel/channel/channel_kakao_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KakaoMapView extends StatelessWidget {
  KakaoMapView({
    required this.channel,
    this.lat = 33.541130,
    this.lon = 126.669621,
    this.zoomLevel = 14,
  });

  final KakaoMapChannel channel;

  double lat;
  double lon;
  int zoomLevel;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> creationParams = {
      'lat': lat,
      'lon': lon,
      'zoomLevel': zoomLevel
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'map-kakao',
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
        // onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'map-kakao',
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
        // onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('Unsupported platform');
  }

  void _onPlatformViewCreated(int id) {
    channel.initChannel(id);
  }
}