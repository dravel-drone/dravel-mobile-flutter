import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/util_ui.dart';

class PlaceItem extends StatelessWidget {
  PlaceItem({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.address,
    this.message,
    required this.distance,
    this.backgroundColor = Colors.white
  });

  String? imageUrl;
  String name;
  String? message;
  String address;

  int distance;
  Color backgroundColor;

  int id;

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
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  height: double.infinity,
                  width: 85,
                  fit: BoxFit.cover,
                  imageUrl: imageUrl!,
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 85,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(id + 4353453)
                      )
                  ),
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
                            overflow: TextOverflow.ellipsis,
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
                      message ?? '',
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
                        Expanded(
                          child: Text(
                            address,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              height: 1
                            ),
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