import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/carousel/carousel_spot_recommend.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Column(
          children: [
            Text(
              '여행지 탐색',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 24,),
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
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 9/10
              )
            ),
          ],
        ),
      ),
    );
  }
}
