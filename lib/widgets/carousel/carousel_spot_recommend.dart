import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:flutter/material.dart';

class DroneSpotRecommendCard extends StatelessWidget{
  DroneSpotRecommendCard({
    required this.id,
    required this.name,
    required this.content,
    required this.like_count,
    this.imageUrl,
    this.address,
    this.onTap,
    this.isLiked = false,
  });

  String? imageUrl;
  String name;
  String content;
  String? address;

  int like_count;
  int id;

  bool isLiked;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                if (imageUrl != null)
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: HttpBase.baseUrl + imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: getRandomGradientColor(id + 74353)
                      )
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(24),
                  color: Color(0x40000000),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        content,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.pink[300] : Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 4,),
                            Text(
                              '$like_count',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12,),

                            if (address != null)
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 18,
                              ),
                            if (address != null)
                              SizedBox(width: 4,),
                            if (address != null)
                              Expanded(
                                child: Text(
                                  address!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        )
    );
  }
}