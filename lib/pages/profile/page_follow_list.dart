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

  List<dynamic> _followerTestData = [
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508138221679-760a23a2285b?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
  ];

  List<dynamic> _followingTestData = [
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
    {
      'url': 'https://images.unsplash.com/photo-1719344340081-b6d9b7d997a9?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': 'sdjiaod'
    },
  ];

  Widget _createFollowerList() {
    return Container();
  }

  Widget _createFollowingList() {
    return Container();
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
      ),
      body: widget.mode == FollowListPage.FOLLOWER_MODE ?
        _createFollowerList() : _createFollowingList(),
    );
  }
}
