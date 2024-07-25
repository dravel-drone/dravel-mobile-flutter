import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DroneSpotRecommendCard extends StatelessWidget{
  DroneSpotRecommendCard({
    required this.name,
    required this.content,
    required this.imageUrl,
    required this.address,
    required this.like_count,
    this.onTap,
  });

  String imageUrl;
  String name;
  String content;
  String address;

  int like_count;

  Function()? onTap;

  Widget _createInfoItem({
    required IconData icon,
    required String text
  }) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: Colors.white,
        size: 18,
      ),
      SizedBox(width: 4,),
      Text(
        text,
        style: TextStyle(
            color: Colors.white
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: GestureDetector(
          onTap: () {

          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _createInfoItem(
                            icon: Icons.favorite,
                            text: '$like_count'
                          ),
                          SizedBox(width: 12,),
                          _createInfoItem(
                              icon: Icons.location_on,
                              text: address
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}