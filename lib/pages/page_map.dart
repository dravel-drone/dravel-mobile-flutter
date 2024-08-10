import 'dart:math';

import 'package:dravel/channel/channel_kakao_map.dart';
import 'package:dravel/pages/detail/page_dronespot_detail.dart';
import 'package:dravel/pages/search/page_dronespot_search.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/map/map_kakao.dart';
import 'package:dravel/widgets/sheet/sheet_grab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  KakaoMapChannel _kakaoMapChannel = KakaoMapChannel();
  late final ScrollController _bottomSheetContentController;
  late final SnappingSheetController _snappingSheetController;

  int _selectedDrone = -1;

  List<Map<String, dynamic>> _droneSpotTestData = [];

  Future<void> _fetchDataFromNetwork() async {
    await Future.delayed(Duration(milliseconds: 600));
    _droneSpotTestData = [
      {
        'id': 0,
        'img': 'https://images.unsplash.com/photo-1500531279542-fc8490c8ea4d?q=80&w=1742&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'name': '거제도',
        'like_count': 234,
        'review_count': 4354,
        'location': {
          'lat': 33.539206,
          'lon': 126.667611
        },
        'flight': 0,
        'camera': 2,
        'address': '경상남도 거제시'
      },
      {
        'id': 1,
        'img': 'https://images.unsplash.com/photo-1485086806232-72035a9f951c?q=80&w=1635&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'name': '두바이',
        'like_count': 4353,
        'review_count': 123,
        'location': {
          'lat': 33.549862,
          'lon': 126.678342
        },
        'flight': 1,
        'camera': 1,
        'address': '경상남도 두바이시'
      },
      {
        'id': 2,
        'img': 'https://images.unsplash.com/photo-1494412519320-aa613dfb7738?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'name': '부산항',
        'like_count': 234,
        'review_count': 4354,
        'location': {
          'lat': 33.546361,
          'lon': 126.659556
        },
        'flight': 2,
        'camera': 2,
        'address': '경상남도 부산시'
      },
      {
        'id': 3,
        'img': 'https://images.unsplash.com/photo-1500531279542-fc8490c8ea4d?q=80&w=1742&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'name': '거제도',
        'like_count': 234,
        'review_count': 4354,
        'location': {
          'lat': 33.532850,
          'lon': 126.674042
        },
        'flight': 0,
        'camera': 2,
        'address': '경상남도 거제시'
      },
      {
        'id': 4,
        'img': 'https://images.unsplash.com/photo-1485086806232-72035a9f951c?q=80&w=1635&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'name': '두바이',
        'like_count': 4353,
        'review_count': 123,
        'location': {
          'lat': 33.539337,
          'lon': 126.659079
        },
        'flight': 1,
        'camera': 1,
        'address': '경상남도 두바이시'
      },
      {
        'id': 5,
        'img': 'https://images.unsplash.com/photo-1494412519320-aa613dfb7738?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'name': '부산항',
        'like_count': 234,
        'review_count': 4354,
        'location': {
          'lat': 33.538301,
          'lon': 126.654998
        },
        'flight': 2,
        'camera': 2,
        'address': '경상남도 부산시'
      },
    ];
    setState(() {
      for (var i in _droneSpotTestData) {
        _kakaoMapChannel.addSpotLabel(
          lat: i['location']['lat'],
          lon: i['location']['lon'],
          name: i['name'],
          id: i['id']
        );
      }
    });
  }

  @override
  void initState() {
    _bottomSheetContentController = ScrollController();
    _snappingSheetController = SnappingSheetController();
    _bottomSheetContentController.addListener(() {
      _detectListViewIdx();
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _fetchDataFromNetwork());
    super.initState();
  }

  @override
  void dispose() {
    _bottomSheetContentController.dispose();
    super.dispose();
  }

  void _detectListViewIdx() {
    double offset = _bottomSheetContentController.offset;

    final double totalItemHeight = 152 + 16;
    final double effectiveOffset = offset - 24;

    int currentIndex = (effectiveOffset / totalItemHeight).floor();
    if (currentIndex < 0) currentIndex = 0;

    // if (_bottomSheetContentController.position.pixels >=
    //     _bottomSheetContentController.position.maxScrollExtent) currentIndex = _droneSpotTestData.length - 1;

    debugPrint("offset: $offset index: $currentIndex");
  }

  void _moveListViewTo(int idx) {
    const double totalItemHeight = 152 + 16;
    double itemIdx = totalItemHeight * idx;
    itemIdx += 24;
    _bottomSheetContentController.animateTo(
      itemIdx,
      duration: Duration(milliseconds: 350),
      curve: Curves.ease
    );
  }

  Widget _createChip({
    required int index,
    required String name
  }) {
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
          GestureDetector(
            onTap: () async {
              Get.to(() => DroneSpotSearchPage());
            },
            child: Material(
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

  Widget _createBottomSheetContent() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        controller: _bottomSheetContentController,
        itemBuilder: (context, idx) {
          return DroneSpotItem(
            name: _droneSpotTestData[idx]['name'],
            imageUrl: _droneSpotTestData[idx]['img'],
            address: _droneSpotTestData[idx]['address'],
            like_count: _droneSpotTestData[idx]['like_count'],
            review_count: _droneSpotTestData[idx]['review_count'],
            camera_level: _droneSpotTestData[idx]['camera'],
            fly_level: _droneSpotTestData[idx]['flight'],
            backgroundColor: Color(0xFFF1F1F5),
            onTap: () {
              Get.to(() => DroneSpotDetailPage());
            },
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(height: 16,);
        },
        itemCount: _droneSpotTestData.length
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SnappingSheet(
        controller: _snappingSheetController,
        grabbing: GrabbingWidget(),
        grabbingHeight: 45,
        snappingPositions: const [
          SnappingPosition.factor(
            positionFactor: 0,
            grabbingContentOffset: GrabbingContentOffset.top,
          ),
          SnappingPosition.factor(
              positionFactor: 0.45
          ),
          SnappingPosition.factor(
              positionFactor: 0.73
          ),
        ],
        lockOverflowDrag: true,
        sheetAbove: null,
        sheetBelow: SnappingSheetContent(
            draggable: false,
            // childScrollController: _bottomSheetContentController,
            child: _createBottomSheetContent()
        ),
        child: Stack(
          children: [
            KakaoMapView(
              channel: _kakaoMapChannel,
              initData: _droneSpotTestData,
              onMapInit: () {
                print("initMap");
                _fetchDataFromNetwork();
              },
              onLabelTab: (labelId) {
                int idx = -1;
                for (var i = 0;i < _droneSpotTestData.length;i++) {
                  if (_droneSpotTestData[i]['id'] == labelId) {
                    idx = i;
                    break;
                  }
                }
                if (idx == -1) return;
                _snappingSheetController.snapToPosition(
                  const SnappingPosition.factor(
                    positionFactor: 0.45
                  )
                );
                _moveListViewTo(idx);
              },
            ),
            _createTopSection(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
