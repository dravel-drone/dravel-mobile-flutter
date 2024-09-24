import 'dart:math';

import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/channel/channel_kakao_map.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/pages/detail/page_dronespot_detail.dart';
import 'package:dravel/pages/search/page_dronespot_search.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/map/map_kakao.dart';
import 'package:dravel/widgets/no_data.dart';
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
  final KakaoMapChannel _kakaoMapChannel = KakaoMapChannel();
  late final AuthController _authController;
  late final ScrollController _bottomSheetContentController;
  late final SnappingSheetController _snappingSheetController;

  int _selectedDrone = -1;

  List<DroneSpotModel> _droneSpotData = [];

  Future<void> _fetchDataFromNetwork() async {
    debugPrint("dmjiaohnfuoajnfloajfoajnp");
    final result = await DroneSpotHttp.getAllDronespot(
      _authController,
      droneType: _selectedDrone != -1 ? _selectedDrone : null
    );
    if (result == null) {
      if (Get.isSnackbarOpen) Get.back();
      Get.showSnackbar(
        GetSnackBar(
          message: '드론스팟 로드 중 오류가 발생했습니다.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        )
      );
      return;
    }

    _droneSpotData = result;

    List<dynamic> labels = [];

    // await _kakaoMapChannel.removeAllSpotLabel();

    debugPrint(_droneSpotData.length.toString());
    for (var i in _droneSpotData) {
      debugPrint(i.name);
      labels.add({
        'lat': i.location.lat,
        'lon': i.location.lon,
        'name': i.name,
        'id': i.id
      });
    }

    _kakaoMapChannel.setLabels(labels);

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _bottomSheetContentController = ScrollController();
    _snappingSheetController = SnappingSheetController();
    _bottomSheetContentController.addListener(() {
      _detectListViewIdx();
    });
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
            _fetchDataFromNetwork();
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
    if (_droneSpotData.isEmpty) return Container(
      color: Colors.white,
      child: SizedBox(
        height: 100,
        child:  NoDataWidget(
          backgroundColor: Colors.transparent,
        ),
      )
    );

    return Container(
      color: Colors.white,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        physics: ClampingScrollPhysics(),
        controller: _bottomSheetContentController,
        itemBuilder: (context, idx) {
          return DroneSpotItem(
            id: _droneSpotData[idx].id,
            name: _droneSpotData[idx].name,
            imageUrl: _droneSpotData[idx].imageUrl,
            address: _droneSpotData[idx].location.address!,
            like_count: _droneSpotData[idx].likeCount,
            review_count: _droneSpotData[idx].reviewCount,
            camera_level: _droneSpotData[idx].permit.camera,
            fly_level: _droneSpotData[idx].permit.flight,
            isLike: _droneSpotData[idx].isLike,
            backgroundColor: Color(0xFFF1F1F5),
            onTap: () {
              Get.to(() => DroneSpotDetailPage(
                id: _droneSpotData[idx].id,
              ));
            },
            onChange: (value) {
              setState(() {
                _droneSpotData[idx].isLike = value.isLike;
                _droneSpotData[idx].likeCount = value.likeCount;
              });
            }
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(height: 16,);
        },
        itemCount: _droneSpotData.length
      )
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
              // initData: _droneSpotData,
              onMapInit: () {
                print("initMap");
                _fetchDataFromNetwork();
              },
              onLabelTab: (labelId) {
                int idx = -1;
                for (var i = 0;i < _droneSpotData.length;i++) {
                  if (_droneSpotData[i].id == labelId) {
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
