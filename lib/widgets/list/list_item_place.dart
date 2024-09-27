import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/controller/controller_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/util_map.dart';
import '../../utils/util_ui.dart';

class PlaceLocation {
  double lat;
  double lng;

  PlaceLocation({
    required this.lat,
    required this.lng,
  });
}

class PlaceItem extends StatelessWidget {
  PlaceItem({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.address,
    this.message,
    required this.location,
    this.backgroundColor = Colors.white
  });

  String? imageUrl;
  String name;
  String? message;
  String address;

  PlaceLocation location;
  Color backgroundColor;

  int id;

  final LocationController _locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // String urlString = 'kakaomap://open';
        // if (await canLaunchUrlString(urlString)) {
        //   launchUrlString(urlString);
        // } else {
        //   launchUrlString('https://map.kakao.com/link/search/$name');
        // }
        launchUrlString('https://map.kakao.com/link/search/제주 ${name}');
      },
      child: ClipRRect(
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
                    errorWidget: (context, error, obj) {
                      return Container(
                        width: 85,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: getRandomGradientColor(id + 6892163)
                            )
                        ),
                      );
                    },
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
                          Obx(() {
                            if (_locationController.position.value == null) {
                              return const SizedBox();
                            }
                            debugPrint(
                                'place: ${location.lat} ${location.lng} '
                                    'my: ${_locationController.position.value!.latitude} ${_locationController.position.value!.longitude}'
                            );
                            return Text(
                              formatDistance(
                                  Geolocator.distanceBetween(
                                      location.lat,
                                      location.lng,
                                      _locationController.position.value!.latitude,
                                      _locationController.position.value!.longitude
                                  ).round()
                              ),
                              style: TextStyle(
                                  color: Color(0xFF0075FF),
                                  fontSize: 14
                              ),
                            );
                          })
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
      ),
    );
  }
}