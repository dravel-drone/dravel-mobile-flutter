import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/util_map.dart';

class CourseItem extends StatelessWidget {
  CourseItem({
    required this.img,
    required this.name,
    required this.distance,
    required this.duration,
    this.onTap
  });

  String img;
  String name;

  int distance;
  int duration;

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
            color: Color(0xFFF1F1F5),
          ),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
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