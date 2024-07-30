import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowListPage extends StatefulWidget {
  static const bool FOLLOWING_MODE = false;
  static const bool FOLLOWER_MODE = true;

  FollowListPage({
    required this.mode
  });

  final bool mode;

  @override
  State<StatefulWidget> createState() => _FollowListPageState();
}

class _FollowListPageState extends State<FollowListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      appBar: CustomAppbar(
        title: widget.mode == FollowListPage.FOLLOWER_MODE ?
          '팔로워 목록' : '팔로잉 목록',
        textColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
