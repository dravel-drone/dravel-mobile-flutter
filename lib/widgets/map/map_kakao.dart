import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class KakaoMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'map-kakao',
        // onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'map-kakao',
        // onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('Unsupported platform');
  }
}