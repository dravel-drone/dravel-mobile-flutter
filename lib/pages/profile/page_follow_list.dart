import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/list/list_item_follow.dart';
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

  List<dynamic> _followerTestData = [
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod',
      'drone': 'DJI 미니 4 PRO'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830239159-0c1eb0aa06a0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'dasdwd',
      'drone': 'DJI 매빅 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830238873-7e75a4cf5df3?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'efdfsg',
      'drone': 'DJI 에어 2S'
    },
    {
      'url': 'https://images.unsplash.com/photo-1636892488946-d0a0149c3595?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '3434gfe',
      'drone': 'DJI 미니 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod',
      'drone': 'DJI 미니 4 PRO'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830239159-0c1eb0aa06a0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'dasdwd',
      'drone': 'DJI 매빅 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830238873-7e75a4cf5df3?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'efdfsg',
      'drone': 'DJI 에어 2S'
    },
    {
      'url': 'https://images.unsplash.com/photo-1636892488946-d0a0149c3595?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '3434gfe',
      'drone': 'DJI 미니 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod',
      'drone': 'DJI 미니 4 PRO'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830239159-0c1eb0aa06a0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'dasdwd',
      'drone': 'DJI 매빅 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830238873-7e75a4cf5df3?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'efdfsg',
      'drone': 'DJI 에어 2S'
    },
    {
      'url': 'https://images.unsplash.com/photo-1636892488946-d0a0149c3595?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '3434gfe',
      'drone': 'DJI 미니 2'
    },
  ];

  List<dynamic> _followingTestData = [
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'jiokpw4',
      'drone': 'DJI 미니 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830239159-0c1eb0aa06a0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '2rkdoapfk',
      'drone': 'DJI 에어 2S'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830238873-7e75a4cf5df3?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'g0_kopsng',
      'drone': 'DJI 매빅 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1636892488946-d0a0149c3595?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'fik3ojjgk',
      'drone': 'DJI 미니 4 PRO'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'jiokpw4',
      'drone': 'DJI 미니 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830239159-0c1eb0aa06a0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '2rkdoapfk',
      'drone': 'DJI 에어 2S'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830238873-7e75a4cf5df3?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'g0_kopsng',
      'drone': 'DJI 매빅 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1636892488946-d0a0149c3595?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'fik3ojjgk',
      'drone': 'DJI 미니 4 PRO'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'jiokpw4',
      'drone': 'DJI 미니 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830239159-0c1eb0aa06a0?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '2rkdoapfk',
      'drone': 'DJI 에어 2S'
    },
    {
      'url': 'https://images.unsplash.com/photo-1669830238873-7e75a4cf5df3?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'g0_kopsng',
      'drone': 'DJI 매빅 2'
    },
    {
      'url': 'https://images.unsplash.com/photo-1636892488946-d0a0149c3595?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'fik3ojjgk',
      'drone': 'DJI 미니 4 PRO'
    },
  ];

  Widget _createFollowerList() {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(24, 24, 24, getBottomPaddingWithSafeHeight(context, 24)),
      itemBuilder: (context, idx) {
        return FollowerListItem(
          url: _followerTestData[idx]['url'],
          name: _followerTestData[idx]['name'],
          drone: _followerTestData[idx]['drone']
        );
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 16);
      },
      itemCount: _followerTestData.length
    );
  }

  Widget _createFollowingList() {
    return ListView.separated(
        padding: EdgeInsets.fromLTRB(24, 24, 24, getBottomPaddingWithSafeHeight(context, 24)),
        itemBuilder: (context, idx) {
          return FollowingListItem(
              url: _followerTestData[idx]['url'],
              name: _followerTestData[idx]['name'],
              drone: _followerTestData[idx]['drone']
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(height: 16);
        },
        itemCount: _followerTestData.length
    );
  }

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
        surfaceTintColor: Colors.white,
      ),
      body: widget.mode == FollowListPage.FOLLOWER_MODE ?
        _createFollowerList() : _createFollowingList(),
    );
  }
}
