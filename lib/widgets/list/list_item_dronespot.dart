import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/util_ui.dart';

class DroneSpotItem extends StatelessWidget {
  DroneSpotItem({
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.like_count,
    required this.review_count,
    required this.camera_level,
    required this.fly_level,
    this.onTap,
  });

  String imageUrl;
  String name;
  String address;

  int like_count;
  int review_count;
  int camera_level;
  int fly_level;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        // onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          height: 152,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  height: double.infinity,
                  width: 110,
                  fit: BoxFit.cover,
                  imageUrl: imageUrl,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1
                              ),
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Color(0xFF0075FF),
                            size: 16,
                          ),
                          SizedBox(width: 2,),
                          Text(
                            '$like_count',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 6,),
                      getFlyPermitWidget(fly_level),
                      SizedBox(height: 2,),
                      getPicturePermitWidget(camera_level),
                      SizedBox(height: 2,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black54,
                            size: 18,
                          ),
                          SizedBox(width: 4,),
                          Text(
                            address,
                          )
                        ],
                      ),
                      SizedBox(height: 4,),
                      Text(
                        '리뷰 $review_count',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          height: 1
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}