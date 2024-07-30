import 'package:flutter/material.dart';

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
    return Scaffold();
  }
}
