import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/api/http_review.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/model/model_review.dart';
import 'package:dravel/pages/detail/page_course_detail.dart';
import 'package:dravel/pages/detail/page_dronespot_detail.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/carousel/carousel_spot_recommend.dart';
import 'package:dravel/widgets/list/list_item_course.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/util_map.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  late final AuthController _authController;

  int _selectedCarouselCard = 0;
  int _maxReviewCount = 0;

  List<DroneSpotModel> _recommendSpotData = [];

  List<DronespotReviewModel> _recommendReviewData = [];

  List<dynamic> _courseTestData = [
    {
      'img': 'https://images.unsplash.com/photo-1476385822777-70eabacbd41f?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '제주 코스',
      'distance': 2434,
      'duration': 345
    }
  ];

  bool _loadRecommendDronespot = false;

  Future<void> _getRecommendDronespot() async {
    final result = await DroneSpotHttp.getPopularDronespot(_authController);
    if (result != null) {
      _recommendSpotData = result;
    }
    _loadRecommendDronespot = true;
    if (mounted) setState(() {});
  }

  Future<void> _getRecommendReview() async {
    List<DronespotReviewModel>? result = await ReviewHttp.getTrendReview(_authController);

    if (result == null) {
      return;
    }

    _recommendReviewData = result;
    if (_recommendReviewData.length > 3) {
      _maxReviewCount = 3;
    }
    if (mounted) setState(() {});
  }

  Future<void> _initData() async {
    await _getRecommendDronespot();
    await _getRecommendReview();
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _initData();
    super.initState();
  }

  Widget _createDroneSpotRecommendSection() {
    if (!_loadRecommendDronespot) {
      return Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: AspectRatio(
          aspectRatio: 9/12,
          child: Shimmer.fromColors(
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: Color(0x66FFFFFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: 260,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            baseColor: Color(0xFFC6C6C6),
            highlightColor: Colors.white
          ),
        ),
      );
    }
    if (_recommendSpotData.isEmpty) return Container();
    return Column(
      children: [
        CarouselSlider(
            items: List.generate(_recommendSpotData.length, (idx) =>
                DroneSpotRecommendCard(
                  id: _recommendSpotData[idx].id,
                  name: _recommendSpotData[idx].name,
                  content: _recommendSpotData[idx].comment,
                  imageUrl: _recommendSpotData[idx].imageUrl,
                  address: _recommendSpotData[idx].location.address,
                  like_count: _recommendSpotData[idx].likeCount,
                  isLiked: _recommendSpotData[idx].isLike,
                  onTap: () {
                    Get.to(() => DroneSpotDetailPage(id: _recommendSpotData[idx].id));
                  },
                )
            ),
            options: CarouselOptions(
                initialPage: _selectedCarouselCard,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.87,
                enlargeFactor: 0.25,
                aspectRatio: 9/10,
                onPageChanged: (idx, reason) {
                  setState(() {
                    _selectedCarouselCard = idx;
                  });
                }
            )
        ),
        SizedBox(height: 12,),
        AnimatedSmoothIndicator(
          activeIndex: _selectedCarouselCard,
          count: _recommendSpotData.length,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              width: 38,
              height: 12,
              borderRadius: BorderRadius.circular(100),
              color: Color(0xFF0075FF)
            ),
            dotDecoration: DotDecoration(
              width: 12,
              height: 12,
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
            )
          ),
        )
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(_recommendSpotData.length, (idx) {
        //     Widget child;
        //     if (idx == _selectedCarouselCard) {
        //       child = Container(
        //         height: 10,
        //         width: 34,
        //         decoration: BoxDecoration(
        //             color: Color(0xFF0075FF),
        //             borderRadius: BorderRadius.all(
        //                 Radius.circular(40)
        //             )
        //         ),
        //       );
        //     } else {
        //       child = Container(
        //         height: 10,
        //         width: 10,
        //         decoration: BoxDecoration(
        //             color: Colors.black54,
        //             borderRadius: BorderRadius.all(
        //                 Radius.circular(40)
        //             )
        //         ),
        //       );
        //     }
        //     return Padding(
        //       // key: ValueKey<int>(idx == _selectedCarouselCard ? 1 : 0),
        //       padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
        //       child: child,
        //     );
        //   }),
        // )
      ],
    );
  }

  Widget _createCourseRecommendSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오늘의 추천 코스',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1
              ),
            ),
            SizedBox(height: 12,),
            CourseItem(
              id: 434,
              img: _courseTestData[0]['img'],
              name: _courseTestData[0]['name'],
              distance: _courseTestData[0]['distance'],
              duration: _courseTestData[0]['duration'],
              onTap: () {
                Get.to(() => CourseDetailPage());
              },
            )
          ],
        ),
      )
    );
  }

  Widget _createReviewRecommendSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(18, 18, 18, 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '인기 리뷰',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1
              ),
            ),
            SizedBox(height: 12,),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, idx) {
                return ReviewRecommendItem(
                  id: _recommendReviewData[idx].id,
                  img: _recommendReviewData[idx].photoUrl,
                  name: _recommendReviewData[idx].writer?.name,
                  place: _recommendReviewData[idx].placeName,
                  content: _recommendReviewData[idx].comment,
                  likeCount: _recommendReviewData[idx].likeCount,
                  isLike: _recommendReviewData[idx].isLike,
                );
              },
              separatorBuilder: (context, idx) {
                return const SizedBox(
                  height: 14,
                );
              },
              itemCount: _maxReviewCount
            ),
            SizedBox(height: 8,),
            if (_maxReviewCount < _recommendReviewData.length)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _maxReviewCount = _recommendReviewData.length;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '더보기',
                      style: TextStyle(
                        color: Colors.black54
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black54
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: SystemUiOverlayStyle.dark.statusBarBrightness,
        statusBarIconBrightness: SystemUiOverlayStyle.dark.statusBarIconBrightness,
        systemStatusBarContrastEnforced: SystemUiOverlayStyle.dark.systemStatusBarContrastEnforced,
      ),
      child: Material(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24,),
                Text(
                  '여행지 탐색',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1
                  ),
                ),
                SizedBox(height: 18,),
                _createDroneSpotRecommendSection(),
                SizedBox(
                  height: 24,
                ),
                _createCourseRecommendSection(),
                SizedBox(
                  height: 24,
                ),
                _createReviewRecommendSection(),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
