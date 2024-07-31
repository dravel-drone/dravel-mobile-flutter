import 'package:dravel/widgets/map/map_kakao.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: KakaoMapView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
