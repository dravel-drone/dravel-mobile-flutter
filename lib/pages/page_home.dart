import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/utils/util_ui.dart';
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: _recommendSpotTestData[idx]['img'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            color: Color(0x40000000),
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _recommendSpotTestData[idx]['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  _recommendSpotTestData[idx]['content'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          '${_recommendSpotTestData[idx]['like_count']}',
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 12,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          '${_recommendSpotTestData[idx]['address']}',
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                )
              ),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 9/10
              )
            )
          ],
        ),
      ),
    );
  }
}
