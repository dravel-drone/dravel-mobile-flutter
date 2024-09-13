import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_profile.dart';
import 'package:dravel/api/http_review.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_profile.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/pages/profile/page_follow_list.dart';
import 'package:dravel/pages/profile/page_profile_edit.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/error_data.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:dravel/widgets/load_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../api/http_dronespot.dart';
import '../model/model_dronespot.dart';
import '../model/model_review.dart';
import '../utils/util_ui.dart';
import 'detail/page_dronespot_detail.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    this.pageMode = false,
    this.uid
  });

  bool pageMode;
  String? uid;

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;
  late final ScrollController _droneSpotController;
  late final ScrollController _reviewController;
  late final ScrollController _nestedController;

  late final AuthController _authController;

  List<DronespotReviewDetailModel> _reviewData = [];
  List<DroneSpotModel> _dronespotData = [];

  late ProfileModel _profile;

  int _isProfileLoading = -1;
  int _isReviewLoading = -1;
  int _isDronespotLoading = -1;

  Future<bool> _getProfile() async {
    ProfileModel? result = await ProfileHttp.getUserProfile(
        _authController, uid: widget.uid ?? _authController.userUid.value!);

    if (result == null) {
      _isProfileLoading = 0;
    } else {
      _isProfileLoading = 1;
      _profile = result;
    }

    if (mounted) setState(() {});
    return result != null;
  }

  Future<void> _getReview() async {
    _isReviewLoading = -1;
    if (mounted) setState(() {});

    List<DronespotReviewDetailModel>? result = await ReviewHttp.getUserReview(
        _authController, uid: widget.uid ?? _authController.userUid.value!
    );

    if (result == null) {
      _isReviewLoading = 0;
    } else {
      _isReviewLoading = 1;
      _reviewData = result;
    }

    if (mounted) setState(() {});
  }

  Future<void> _getDronespot() async {
    _isDronespotLoading = -1;
    if (mounted) setState(() {});

    List<DroneSpotModel>? result = await DroneSpotHttp.getUserDronespot(
        _authController, uid: widget.uid ?? _authController.userUid.value!
    );

    if (result == null) {
      _isDronespotLoading = 0;
    } else {
      _isDronespotLoading = 1;
      _dronespotData = result;
    }

    if (mounted) setState(() {});
  }

  Future<void> _initData() async {
    bool result = await _getProfile();
    if (!result) return;

    await _getReview();
    await _getDronespot();
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _tabController = TabController(length: 2, vsync: this);
    _reviewController = ScrollController();
    _droneSpotController = ScrollController();
    _nestedController = ScrollController();

    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    _droneSpotController.dispose();
    _nestedController.dispose();
    super.dispose();
  }

  Widget _createAppbar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        _profile.name,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
      ),
      leading: widget.pageMode ? IconButton(
        icon: Icon(Icons.arrow_back_outlined),
        onPressed: () {
          // Get.back();
        },
      ) : null,
      actions: [
        widget.pageMode ? IconButton(
          icon: Icon(Icons.bookmark_border_rounded),
          onPressed: () {
            // Get.back();
          },
        ) : TextButton(
          onPressed: () {
            _authController.logout();
          },
          child: Text('로그아웃')
        )
      ],
    );
  }

  Widget _createProfileInfoText({
    required String name,
    required String value
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          name,
          style: TextStyle(
              height: 1,
              color: Colors.black87,
              fontSize: 14
          ),
        )
      ],
    );
  }

  Widget _createProfileSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: _profile.imageUrl != null ? CachedNetworkImage(
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, obj) {
                    return Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(_profile.uid.hashCode)
                          )
                      ),
                    );
                  },
                  imageUrl: _profile.imageUrl!,
                ) : Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(_profile.uid.hashCode)
                      )
                  ),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: _createProfileInfoText(
                              name: '게시물',
                              value: _profile.postCount.toString()
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FollowListPage(
                                  mode: FollowListPage.FOLLOWER_MODE
                                ));
                              },
                              child: _createProfileInfoText(
                                  name: '팔로워',
                                  value: _profile.followerCount.toString()
                              ),
                            )
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FollowListPage(
                                    mode: FollowListPage.FOLLOWING_MODE
                                ));
                              },
                              child: _createProfileInfoText(
                                  name: '팔로잉',
                                  value: _profile.followingCount.toString()
                              )
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    if (_profile.oneLiner != null)
                      Text(
                        '한줄 소개',
                        style: TextStyle(
                            height: 1,
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                    if (_profile.oneLiner != null)
                      SizedBox(
                        height: 4,
                      ),
                    Text(
                      _profile.oneLiner ?? '',
                      style: TextStyle(
                          height: 1,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      _profile.drone != null
                          ? '대표 드론 - ${_profile.drone}' : '',
                      style: TextStyle(
                          height: 1,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileEditPage());
            },
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                  color: Color(0xFFF1F1F5),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 7, 18, 7),
                child: Center(
                  child: Text(
                    '프로필 편집',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        height: 1
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _createTabbar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        splashBorderRadius: BorderRadius.circular(12),
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Color(0xFF0075FF),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        tabs: [
          Tab(
              text: '게시물'
          ),
          Tab(
              text: '드론스팟'
          )
        ],
      ),
    );
  }

  Widget _createPostList() {
    return ListView.separated(
        key: PageStorageKey('review_profile'),
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        physics: ClampingScrollPhysics(),
        // controller: _reviewController,
        itemBuilder: (context, idx) {
          return ReviewFullItem(
            id: _reviewData[idx].id,
            img: _reviewData[idx].photoUrl,
            name: _reviewData[idx].writer?.name,
            place: _reviewData[idx].placeName,
            content: _reviewData[idx].comment,
            likeCount: _reviewData[idx].likeCount,
            drone: _reviewData[idx].drone,
            date: _reviewData[idx].date,
            isLike: _reviewData[idx].isLike,
            onChange: (value) {
              _reviewData[idx].isLike = value.isLike;
              _reviewData[idx].likeCount = value.likeCount;
            },
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(height: 12,);
        },
        itemCount: _reviewData.length
    );
  }

  Widget _createDroneSpotList() {
    return ListView.separated(
        key: PageStorageKey('drone_profile'),
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        physics: ClampingScrollPhysics(),
        // controller: _droneSpotController,
        itemBuilder: (context, idx) {
          return DroneSpotItem(
              id: _dronespotData[idx].id,
              name: _dronespotData[idx].name,
              imageUrl: _dronespotData[idx].imageUrl,
              address: _dronespotData[idx].location.address!,
              like_count: _dronespotData[idx].likeCount,
              review_count: _dronespotData[idx].reviewCount,
              camera_level: _dronespotData[idx].permit.camera,
              fly_level: _dronespotData[idx].permit.flight,
              isLike: _dronespotData[idx].isLike,
              onTap: () {
                Get.to(() => DroneSpotDetailPage(
                  id: _dronespotData[idx].id,
                ));
              },
              onChange: (value) {
                setState(() {
                  _dronespotData[idx].isLike = value.isLike;
                  _dronespotData[idx].likeCount = value.likeCount;
                });
              }
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(height: 12,);
        },
        itemCount: _dronespotData.length
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_isProfileLoading != 1) {
      if (_isProfileLoading == -1) {
        child = LoadDataWidget();
      } else {
        child = ErrorDataWidget();
      }
      return SafeArea(
        top: false,
        child: Column(
          children: [
            PreferredSize(
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
                      child: CustomAppbar(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        title: "계정 정보",
                        textColor: Colors.black,
                        leading: widget.pageMode ? IconButton(
                          icon: Icon(Icons.arrow_back_outlined),
                          onPressed: () {
                            // Get.back();
                          },
                        ) : null,
                      ),
                    ),
                  ),
                ),
              )
            ),
            Expanded(
              child: Center(
                child: child,
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      top: false,
      child: NestedScrollView(
        controller: _nestedController,
        headerSliverBuilder: (context, value) {
            return [
            _createAppbar(),
            SliverPersistentHeader(
              pinned: false,
              delegate: _SliverAppBarTabDelegate(
                  child: _createProfileSection(),
                  minHeight: 180,
                  maxHeight: 180
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarTabDelegate(
                  child: _createTabbar(),
                  minHeight: 40,
                  maxHeight: 40
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _createPostList(),
            _createDroneSpotList()
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarTabDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarTabDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
