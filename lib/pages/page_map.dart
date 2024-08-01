import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/map/map_kakao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  int _selectedDrone = -1;

  Widget _createChip({
    required int index,
    required String name
  }){
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: SizedBox(
        height: 32,
        child: ChoiceChip(
          label: Text(
            name
          ),
          selected: _selectedDrone == index,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          padding: EdgeInsets.zero,
          side: BorderSide.none,
          onSelected: (selected) {
            setState(() {
              _selectedDrone = selected ? index : -1;
            });
          },
        ),
      ),
    );
  }

  Widget _createTopSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, getTopPaddingWithHeight(context, 20), 24, 0),
      child: Column(
        children: [
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.manage_search,
                    color: Colors.black54,
                    size: 28,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    '드론스팟 검색',
                    style: TextStyle(
                      color: Colors.black45,
                      height: 1,
                      fontSize: 16
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              _createChip(
                index: 0,
                name: '센서'
              ),
              SizedBox(width: 8,),
              _createChip(
                index: 1,
                name: 'fpv'
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          KakaoMapView(),
          _createTopSection(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
