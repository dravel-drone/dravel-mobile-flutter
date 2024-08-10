import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DroneSpotDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DroneSpotDetailPageState();
}

class _DroneSpotDetailPageState extends State<DroneSpotDetailPage> {

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
                  fontSize: 18,
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
        padding: EdgeInsets.fromLTRB(24, 0, 24, getBottomPaddingWithSafeHeight(context, 24)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createInfoSection(),
              SizedBox(height: 24,),
              _createReviewSection()
            ],
          ),
        ),
      ),
    );
  }
}
