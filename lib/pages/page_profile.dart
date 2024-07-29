import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  Widget _createAppbar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0xFFF1F1F5),
            statusBarBrightness: SystemUiOverlayStyle.dark.statusBarBrightness,
            statusBarIconBrightness: SystemUiOverlayStyle.dark.statusBarIconBrightness,
            systemStatusBarContrastEnforced: SystemUiOverlayStyle.dark.systemStatusBarContrastEnforced,
          ),
          child: Material(
            color: Color(0xFFF1F1F5),
            child: Semantics(
              explicitChildNodes: true,
              child: CustomAppbar(
                backgroundColor: Color(0xFFF1F1F5),
                title: "계정 이름",
                textColor: Colors.black,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    // Get.back();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.bookmark_border_rounded),
                    onPressed: () {
                      // Get.back();
                    },
                  )
                ],
              ),
            ),
          ),
        )
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
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: CachedNetworkImage(
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              imageUrl: "https://images.unsplash.com/photo-1498141321056-776a06214e24?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
                        value: '6'
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: _createProfileInfoText(
                        name: '팔로워',
                        value: '120'
                      )
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                        child: _createProfileInfoText(
                          name: '팔로잉',
                          value: '390'
                        )
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Text(
                  '한줄 소개',
                  style: TextStyle(
                    height: 1,
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '프론트엔드 개발자, 여행 블로거',
                  style: TextStyle(
                    height: 1,
                    color: Colors.black54
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '대표 드론 - DJI 매빅 4 PRO',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          _createAppbar(),
          _createProfileSection()
        ],
      ),
    );
  }
}
