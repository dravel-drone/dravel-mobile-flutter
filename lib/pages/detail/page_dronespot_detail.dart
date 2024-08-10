import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DroneSpotDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DroneSpotDetailPageState();
}

class _DroneSpotDetailPageState extends State<DroneSpotDetailPage> {
  List<dynamic> _reviewTestData = [
    {
      'img': 'https://plus.unsplash.com/premium_photo-1675359655401-27e0b11bef70?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '강릉',
      'is_like': false,
      'like_count': 234,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.',
      'write_date': '2024-07-05',
      'drone': '매빅 에어2'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1664801768830-46734d0f0848?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '아늘기',
      'place': '신안',
      'is_like': true,
      'like_count': 394,
      'content': '테스트',
      'write_date': '2023-11-05',
      'drone': '매빅 미니4 PRO'
    },
    {
      'img': 'https://images.unsplash.com/photo-1465447142348-e9952c393450?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '서울',
      'is_like': false,
      'like_count': 345,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.',
      'write_date': '2024-02-17',
      'drone': '매빅 에어3'
    },
  ];

  Widget _createInfoSection() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: 120,
            width: 120,
            fit: BoxFit.cover,
            imageUrl: 'https://images.unsplash.com/photo-1500531279542-fc8490c8ea4d?q=80&w=1742&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
        SizedBox(width: 14,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '센서드론',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Color(0xFF0075FF),
                    size: 16,
                  ),
                  SizedBox(width: 2,),
                  Text(
                    '54',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14
                    ),
                  )
                ],
              ),
              Text(
                '사전합의구역',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),
              getFlyPermitWidget(0,
              style: TextStyle(
                color: Colors.black54
              )),
              SizedBox(height: 2,),
              getPicturePermitWidget(2,
              style: TextStyle(
                  color: Colors.black54
              )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(width: 4,),
                  Text(
                    '서귀포시 안덕면 사계리',
                    style: TextStyle(
                      color: Colors.black54
                    ),
                  )
                ],
              ),
              Text(
                '현재 12도 / 맑음',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _createReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '최근 리뷰',
                style: TextStyle(
                  height: 1,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: Text(
                '더보기 >',
                style: TextStyle(
                  color: Colors.black38,
                  height: 1
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 12,),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, idx) {
            return ReviewFullItem(
                img: _reviewTestData[idx]['img'],
                name: _reviewTestData[idx]['name'],
                place: _reviewTestData[idx]['place'],
                content: _reviewTestData[idx]['content'],
                likeCount: _reviewTestData[idx]['like_count'],
                drone: _reviewTestData[idx]['drone'],
                date: _reviewTestData[idx]['write_date']
            );;
          },
          separatorBuilder: (context, idx) {
            return SizedBox(height: 12,);
          },
          itemCount: _reviewTestData.length
        ),
        SizedBox(height: 12,),
        SizedBox(
          width: double.infinity,
          child: MainButton(
              onPressed: () {

              },
              childText: '리뷰 작성하기'
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      appBar: CustomAppbar(
        title: "장소이름",
        textColor: Colors.black,
        backgroundColor: Color(0xFFF1F1F5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createInfoSection(),
              SizedBox(height: 24,),
              _createReviewSection(),
              SizedBox(
                height: getBottomPaddingWithSafeHeight(context, 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
