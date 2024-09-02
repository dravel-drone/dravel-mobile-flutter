import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:flutter/material.dart';

import '../../utils/util_map.dart';
import '../../utils/util_ui.dart';

class CourseItem extends StatelessWidget {
  CourseItem({
    this.img,
    required this.id,
    required this.name,
    required this.distance,
    required this.duration,
    this.sectionColor = const Color(0xFFF1F1F5),
    this.onTap
  });

  String? img;
  String name;

  int distance;
  int duration;

  int id;

  Color sectionColor;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: sectionColor,
          ),
          child: Column(
            children: [
              if (img != null)
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: HttpBase.baseUrl + img!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              else
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: getRandomGradientColor(id + 4353453)
                        )
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.outlined_flag_rounded,
                          // color: Color(0xFF0075FF),
                          size: 14,
                        ),
                        SizedBox(width: 2,),
                        Text(
                          formatDistance(distance),
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12
                          ),
                        ),
                        SizedBox(width: 8,),
                        Icon(
                          Icons.schedule_rounded,
                          // color: Color(0xFF0075FF),
                          size: 14,
                        ),
                        SizedBox(width: 2,),
                        Text(
                          formatTime(duration),
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}