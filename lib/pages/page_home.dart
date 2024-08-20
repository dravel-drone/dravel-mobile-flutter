import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/pages/detail/page_course_detail.dart';
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
  int _selectedCarouselCard = 0;
  int _maxReviewCount = 0;

  List<DroneSpotModel> _recommendSpotData = [];

  List<dynamic> _recommendReviewTestData = [
    {
      'img': 'https://plus.unsplash.com/premium_photo-1675359655401-27e0b11bef70?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '강릉',
      'is_like': false,
      'like_count': 234,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1664801768830-46734d0f0848?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '아늘기',
      'place': '신안',
      'is_like': true,
      'like_count': 394,
      'content': '테스트'
    },
    {
      'img': 'https://images.unsplash.com/photo-1465447142348-e9952c393450?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '서울',
      'is_like': false,
      'like_count': 345,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.'
    },
    {
      'img': 'https://images.unsplash.com/photo-1473773508845-188df298d2d1?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '가흘스',
      'place': '강원',
      'is_like': false,
      'like_count': 34,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1675359655401-27e0b11bef70?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '강릉',
      'is_like': false,
      'like_count': 234,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1664801768830-46734d0f0848?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '아늘기',
      'place': '신안',
      'is_like': true,
      'like_count': 394,
      'content': '국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경제의 발전에 노력하여야 한다. 국가는 재해를 예방하고 그 위험으로부터 국민을 보호하기 위하여 노력하여야 한다. 국군은 국가의 안전보장과 국토방위의 신성한 의무를 수행함을 사명으로 하며, 그 정치적 중립성은 준수된다. 법률안에 이의가 있을 때에는 대통령은 제1항의 기간내에 이의서를 붙여 국회로 환부하고, 그 재의를 요구할 수 있다. 국회의 폐회중에도 또한 같다.'
    },
    {
      'img': 'https://images.unsplash.com/photo-1465447142348-e9952c393450?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '서울',
      'is_like': false,
      'like_count': 345,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.'
    },
    {
      'img': 'https://images.unsplash.com/photo-1473773508845-188df298d2d1?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '가흘스',
      'place': '강원',
      'is_like': false,
      'like_count': 34,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.'
    },
  ];

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
    final result = await DroneSpotHttp.getPopularDronespot();
    if (result != null) {
      _recommendSpotData = result;
    }
    _loadRecommendDronespot = true;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    if (_recommendReviewTestData.length > 3) {
      _maxReviewCount = 3;
    }
    _getRecommendDronespot();
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
                  like_count: _recommendSpotData[idx].likeCount
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
                  img: _recommendReviewTestData[idx]['img'],
                  name: _recommendReviewTestData[idx]['name'],
                  place: _recommendReviewTestData[idx]['place'],
                  content: _recommendReviewTestData[idx]['content'],
                  likeCount: _recommendReviewTestData[idx]['like_count']
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
            if (_maxReviewCount < _recommendReviewTestData.length)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _maxReviewCount = _recommendReviewTestData.length;
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
