import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_profile.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_profile.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/list/list_item_follow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/error_data.dart';
import '../../widgets/load_data.dart';

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
  late final AuthController _authController;

  List<FollowModel> _followerData = [];
  List<FollowModel> _followingData = [];

  int _isLoad = -1;

  Future<void> _getData() async {
    _isLoad = -1;
    if (mounted) setState(() {});

    List<FollowModel>? result = await ProfileHttp.getFollowList(
      _authController,
      widget.mode
    );

    if (result == null) {
      _isLoad = 0;
    } else {
      if (widget.mode == FollowListPage.FOLLOWING_MODE) {
        _followingData = result;
      } else {
        _followerData = result;
      }

      _isLoad = 1;
    }

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _getData();
    super.initState();
  }

  Widget _createFollowerList() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24, 24, 24, getBottomPaddingWithSafeHeight(context, 24)),
      itemBuilder: (context, idx) {
        return FollowerListItem(
          url: _followerData[idx].imageUrl,
          name: _followerData[idx].name,
          uid: _followerData[idx].uid,
          drone: _followerData[idx].drone ?? '',
          onDelete: () async {
            Get.dialog(
                AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 24,),
                      Text(
                        '팔로워 삭제중..',
                        style: TextStyle(
                            height: 1
                        ),
                      )
                    ],
                  ),
                  actionsPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                ),
                barrierDismissible: false
            );

            final bool? result = await ProfileHttp.deleteFollower(
              Get.find<AuthController>(),
              uid: _followerData[idx].uid,
            );

            bool? isDialogOpen = Get.isDialogOpen;
            if (isDialogOpen != null && isDialogOpen) Get.back();
            if (result != null) {
              _followerData.clear();
              _getData();
            } else {
              if (Get.isSnackbarOpen) Get.back();
              Get.showSnackbar(
                  GetSnackBar(
                    message: '오류가 발생했습니다. 다시 시도해주세요.',
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                  )
              );
            }
          },
        );
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 16);
      },
      itemCount: _followerData.length
    );
  }

  Widget _createFollowingList() {
    return ListView.separated(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(24, 24, 24, getBottomPaddingWithSafeHeight(context, 24)),
        itemBuilder: (context, idx) {
          return FollowingListItem(
            url: _followingData[idx].imageUrl,
            name: _followingData[idx].name,
            uid: _followingData[idx].uid,
            drone: _followingData[idx].drone ?? '',
            isFollow: _followingData[idx].isFollow,
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(height: 16);
        },
        itemCount: _followingData.length
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_isLoad != 1) {
      if (_isLoad == -1) {
        child = LoadDataWidget();
      } else {
        child = ErrorDataWidget();
      }
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
        body: child
      );
    }

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
