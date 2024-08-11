import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/util_ui.dart';

class PlaceItem extends StatelessWidget {
  PlaceItem({
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.message,
    required this.distance,
    this.backgroundColor = Colors.white
  });

  String imageUrl;
  String name;
  String message;
  String address;

  int distance;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                height: double.infinity,
                width: 85,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 4, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          '${distance}m',
                          style: TextStyle(
                              color: Color(0xFF0075FF),
                              fontSize: 14
                          ),
                        )
                      ],
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          height: 1
                      ),
                    ),
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
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}