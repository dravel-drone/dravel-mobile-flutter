import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/carousel/carousel_spot_recommend.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCarouselCard = 0;

  List<dynamic> _recommendSpotTestData = [
    {
      'img': 'https://images.unsplash.com/photo-1643785005361-947c91314690?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '스위스',
      'content': '깎은듯한 날카로운 산이 모여있는 장소',
      'like_count': 193,
      'address': '경기도 스위스시 스위스동'
    },
    {
      'img': 'https://images.unsplash.com/photo-1695321924057-91977a88eae1?q=80&w=1750&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '제주도',
      'content': '해질녘 평화로운 제주도의 오름',
      'like_count': 453,
      'address': '제주특별시 애월시 애월읍'
    },
  ];

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

  Widget _createDroneSpotRecommendSection() {
    return Column(
      children: [
        CarouselSlider(
            items: List.generate(_recommendSpotTestData.length, (idx) =>
                DroneSpotRecommendCard(
                    name: _recommendSpotTestData[idx]['name'],
                    content: _recommendSpotTestData[idx]['content'],
                    imageUrl: _recommendSpotTestData[idx]['img'],
                    address: _recommendSpotTestData[idx]['address'],
                    like_count: _recommendSpotTestData[idx]['like_count']
                )
            ),
            options: CarouselOptions(
                initialPage: _selectedCarouselCard,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 9/10,
                onPageChanged: (idx, reason) {
                  setState(() {
                    _selectedCarouselCard = idx;
                  });
                }
            )
        ),
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_recommendSpotTestData.length, (idx) {
            Widget child;
            if (idx == _selectedCarouselCard) {
              child = Container(
                height: 10,
                width: 34,
                decoration: BoxDecoration(
                    color: Color(0xFF0075FF),
                    borderRadius: BorderRadius.all(
                        Radius.circular(40)
                    )
                ),
              );
            } else {
              child = Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(
                        Radius.circular(40)
                    )
                ),
              );
            }
            return Padding(
              key: ValueKey<int>(idx == _selectedCarouselCard ? 1 : 0),
              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: child,
            );
          }),
        )
      ],
    );
  }

  Widget _createReviewRecommendSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(18, 24, 18, 12),
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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xFFF1F1F5),
                    ),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: _recommendReviewTestData[idx]['img'],
                          width: 100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _recommendReviewTestData[idx]['name'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF0075FF)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _recommendReviewTestData[idx]['place'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _recommendReviewTestData[idx]['content'],
                                  style: TextStyle(
                                    color: Colors.black54
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, idx) {
                return const SizedBox(
                  height: 14,
                );
              },
              itemCount: _recommendReviewTestData.length
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              _createReviewRecommendSection(),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
