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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../model/model_dronespot.dart';
import 'detail/page_dronespot_detail.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final AuthController _authController;

  late final TabController _tabController;

  final PagingController<int, DroneSpotModel> _dronespotPagingController = PagingController(firstPageKey: 1);
  final PagingController<int, DronespotReviewDetailModel> _reviewPagingController = PagingController(firstPageKey: 1);

  int _selectedTab = 0;
  int _pageSize = 25;

  Future<void> _getLikeDronespot(int pageKey) async {
    print(pageKey);
    List<DroneSpotModel>? result = await DroneSpotHttp.getLikedDronespot(
      _authController,
      page: pageKey ~/_pageSize + 1,
      size: _pageSize
    );

    if (result == null) {
      // _droneLikeData = [];
    } else {
      final isLastPage = result.length < _pageSize;
      if (isLastPage) {
        _dronespotPagingController.appendLastPage(result);
      } else {
        final nextPageKey = pageKey + result.length;
        _dronespotPagingController.appendPage(result, nextPageKey);
      }
    }

    // if (mounted) setState(() {});
  }

  Future<void> _getLikeReview(int pageKey) async {
    List<DronespotReviewDetailModel>? result = await ReviewHttp.getLikeReview(
      _authController,
      page: pageKey ~/_pageSize + 1,
      size: _pageSize
    );

    if (result == null) {
      // _reviewLikeData = [];
    } else {
      final isLastPage = result.length < _pageSize;
      if (isLastPage) {
        _reviewPagingController.appendLastPage(result);
      } else {
        final nextPageKey = pageKey + result.length;
        _reviewPagingController.appendPage(result, nextPageKey);
      }
    }

    // if (mounted) setState(() {});
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _tabController = TabController(
      length: 2,
      vsync: this
    );
    _dronespotPagingController.addPageRequestListener((pageKey) {
      _getLikeDronespot(pageKey);
    });
    _reviewPagingController.addPageRequestListener((pageKey) {
      _getLikeReview(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewPagingController.dispose();
    _dronespotPagingController.dispose();
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
    return PagedListView<int, DroneSpotModel>.separated(
      key: PageStorageKey('drone'),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      // physics: ClampingScrollPhysics(),
      pagingController: _dronespotPagingController,
      builderDelegate: PagedChildBuilderDelegate<DroneSpotModel>(
        itemBuilder: (context, item, idx) => DroneSpotItem(
            id: item.id,
            name: item.name,
            imageUrl: item.imageUrl,
            address: item.location.address!,
            like_count: item.likeCount,
            review_count: item.reviewCount,
            camera_level: item.permit.camera,
            fly_level: item.permit.flight,
            isLike: item.isLike,
            onTap: () {
              Get.to(() => DroneSpotDetailPage(
                id: item.id,
              ));
            },
            onChange: (value) {
              setState(() {
                item.isLike = value.isLike;
                item.likeCount = value.likeCount;
              });
            }
        ),
      ),
      separatorBuilder: (context, idx) {
        return SizedBox(height: 12,);
      },
    );
  }

  Widget _createReviewLikeSection() {
    return PagedListView<int, DronespotReviewDetailModel>.separated(
      key: PageStorageKey('review'),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      // physics: ClampingScrollPhysics(),
      pagingController: _reviewPagingController,
      builderDelegate: PagedChildBuilderDelegate<DronespotReviewDetailModel>(
        itemBuilder: (context, item, idx) => ReviewFullItem(
          id: item.id,
          img: item.photoUrl,
          name: item.writer?.name,
          writerUid: item.writer?.uid,
          place: item.placeName,
          content: item.comment,
          likeCount: item.likeCount,
          drone: item.drone,
          date: item.date,
          isLike: item.isLike,
          onChange: (value) {
            item.isLike = value.isLike;
            item.likeCount = value.likeCount;
          },
        ),
      ),
      separatorBuilder: (context, idx) {
        return SizedBox(height: 12,);
      },
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
