import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/pages/profile/page_follow_list.dart';
import 'package:flutter/material.dart';

import '../../api/http_base.dart';
import '../../utils/util_ui.dart';

class _FollowListItem extends StatelessWidget {
  _FollowListItem({
    required this.url,
    required this.name,
    required this.drone,
    required this.buttonText,
    required this.onTap,
    required this.uid,
    this.buttonBackgroundColor = Colors.white,
    this.buttonTextColor = Colors.black54
  });

  String? url;
  String name;
  String drone;
  String uid;

  String buttonText;
  Color buttonBackgroundColor;
  Color buttonTextColor;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: url != null ? CachedNetworkImage(
            width: 48,
            height: 48,
            errorWidget: (context, error, obj) {
              return Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: getRandomGradientColor(uid.hashCode)
                    )
                ),
              );
            },
            fit: BoxFit.cover,
            imageUrl: HttpBase.baseUrl +  url!,
          ) : Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: getRandomGradientColor(uid.hashCode)
                )
            ),
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
                    color: buttonTextColor,
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
    required this.uid,
  });

  String? url;
  String name;
  String drone;
  String uid;

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
      uid: widget.uid,
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
    required this.uid,
    this.isFollow = true
  });

  String? url;
  String name;
  String drone;
  String uid;

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
      uid: widget.uid,
      buttonText: widget.isFollow ? '언팔로우' : '팔로우',
      buttonBackgroundColor: widget.isFollow ? Colors.white : Colors.black87,
      buttonTextColor: widget.isFollow ? Colors.black54 : Colors.white,
      onTap: () {
        setState(() {
          widget.isFollow = !widget.isFollow;
        });
      }
    );
  }
}
