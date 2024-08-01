import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KakaoMapView extends StatelessWidget {
  KakaoMapView({
    this.lat = 33.541130,
    this.lon = 126.669621,
    this.zoomLevel = 14,
  });

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
        creationParamsCodec: StandardMessageCodec(),
        // onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'map-kakao',
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: StandardMessageCodec(),
        // onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('Unsupported platform');
  }
}