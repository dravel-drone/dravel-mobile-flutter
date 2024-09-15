import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/api/http_review.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_review.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/model_dronespot.dart';
import 'detail/page_dronespot_detail.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AuthController _authController;

  late final TabController _tabController;
  late final ScrollController _droneSpotController;
  late final ScrollController _reviewController;

  int _selectedTab = 0;

  List<DroneSpotModel> _droneLikeData = [];


  List<DronespotReviewDetailModel> _reviewLikeData = [];

  Future<void> _getLikeDronespot() async {
    List<DroneSpotModel>? result = await DroneSpotHttp.getLikedDronespot(_authController);

    if (result == null) {
      _droneLikeData = [];
    } else {
      _droneLikeData = result;
    }

    if (mounted) setState(() {});
  }

  Future<void> _getLikeReview() async {
    List<DronespotReviewDetailModel>? result = await ReviewHttp.getLikeReview(_authController);

    if (result == null) {
      _reviewLikeData = [];
    } else {
      _reviewLikeData = result;
    }

    if (mounted) setState(() {});
  }

  Future<void> _initData() async {
    await _getLikeDronespot();
    await _getLikeReview();
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _tabController = TabController(
      length: 2,
      vsync: this
    );
    _reviewController = ScrollController();
    _droneSpotController = ScrollController();
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    _droneSpotController.dispose();
    super.dispose();
  }

  Widget _createAppbar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: SystemUiOverlayStyle.dark.statusBarBrightness,
            statusBarIconBrightness: SystemUiOverlayStyle.dark.statusBarIconBrightness,
            systemStatusBarContrastEnforced: SystemUiOverlayStyle.dark.systemStatusBarContrastEnforced,
          ),
          child: Material(
            color: Colors.white,
            child: Semantics(
              explicitChildNodes: true,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '좋아요',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TabBar(
                      controller: _tabController,
                      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black54,
                      labelPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                      labelColor: Color(0xFF0075FF),
                      indicatorColor: Color(0xFF0075FF),
                      tabs: const [
                        Tab(text: "드론스팟"),
                        Tab(text: "리뷰"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _createDroneSpotLikeSection() {
    return ListView.separated(
      key: PageStorageKey('drone'),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      physics: ClampingScrollPhysics(),
      controller: _droneSpotController,
      itemBuilder: (context, idx) {
        return DroneSpotItem(
            id: _droneLikeData[idx].id,
            name: _droneLikeData[idx].name,
            imageUrl: _droneLikeData[idx].imageUrl,
            address: _droneLikeData[idx].location.address!,
            like_count: _droneLikeData[idx].likeCount,
            review_count: _droneLikeData[idx].reviewCount,
            camera_level: _droneLikeData[idx].permit.camera,
            fly_level: _droneLikeData[idx].permit.flight,
            isLike: _droneLikeData[idx].isLike,
            onTap: () {
              Get.to(() => DroneSpotDetailPage(
                id: _droneLikeData[idx].id,
              ));
            },
            onChange: (value) {
              setState(() {
                _droneLikeData[idx].isLike = value.isLike;
                _droneLikeData[idx].likeCount = value.likeCount;
              });
            }
        );
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 12,);
      },
      itemCount: _droneLikeData.length
    );
  }

  Widget _createReviewLikeSection() {
    return ListView.separated(
      key: PageStorageKey('review'),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      physics: ClampingScrollPhysics(),
      controller: _reviewController,
      itemBuilder: (context, idx) {
        return ReviewFullItem(
          id: _reviewLikeData[idx].id,
          img: _reviewLikeData[idx].photoUrl,
          name: _reviewLikeData[idx].writer?.name,
          writerUid: _reviewLikeData[idx].writer?.uid,
          place: _reviewLikeData[idx].placeName,
          content: _reviewLikeData[idx].comment,
          likeCount: _reviewLikeData[idx].likeCount,
          drone: _reviewLikeData[idx].drone,
          date: _reviewLikeData[idx].date,
          isLike: _reviewLikeData[idx].isLike,
          onChange: (value) {
            _reviewLikeData[idx].isLike = value.isLike;
            _reviewLikeData[idx].likeCount = value.likeCount;
          },
        );
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 12,);
      },
      itemCount: _reviewLikeData.length
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          _createAppbar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _createDroneSpotLikeSection(),
                _createReviewLikeSection()
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
