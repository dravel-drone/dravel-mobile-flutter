import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/pages/profile/page_follow_list.dart';
import 'package:flutter/material.dart';

class _FollowListItem extends StatelessWidget {
  _FollowListItem({
    required this.url,
    required this.name,
    required this.drone,
    required this.buttonText,
    required this.onTap,
    this.buttonBackgroundColor = Colors.white
  });

  String url;
  String name;
  String drone;

  String buttonText;
  Color buttonBackgroundColor;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: CachedNetworkImage(
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            imageUrl: url,
          ),
        ),
        SizedBox(width: 12,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 2,),
              Text(
                drone,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1
                ),
              ),
            ],
          ),
        ),
        Ink(
          decoration: BoxDecoration(
              color: buttonBackgroundColor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
              child: Text(
                buttonText,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1
                ),
              ),
            ),
          ),
        )
      ],
    );;
  }
}


class FollowerListItem extends StatefulWidget {
  FollowerListItem({
    required this.url,
    required this.name,
    required this.drone,
  });

  String url;
  String name;
  String drone;

  @override
  State<StatefulWidget> createState() => _FollowerListItemState();
}

class _FollowerListItemState extends State<FollowerListItem> {
  @override
  Widget build(BuildContext context) {
    return _FollowListItem(
      url: widget.url,
      name: widget.name,
      drone: widget.drone,
      buttonText: '삭제',
      onTap: () {

      }
    );
  }
}


class FollowingListItem extends StatefulWidget {
  FollowingListItem({
    required this.url,
    required this.name,
    required this.drone,
    this.isFollow = true
  });

  String url;
  String name;
  String drone;

  bool isFollow;

  @override
  State<StatefulWidget> createState() => _FollowingListItemState();
}

class _FollowingListItemState extends State<FollowingListItem> {
  @override
  Widget build(BuildContext context) {
    return _FollowListItem(
      url: widget.url,
      name: widget.name,
      drone: widget.drone,
      buttonText: widget.isFollow ? '언팔로우' : '팔로우',
      onTap: () {

      }
    );
  }
}
