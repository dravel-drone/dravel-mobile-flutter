import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/util_ui.dart';

class DroneSpotItem extends StatefulWidget {
  DroneSpotItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.like_count,
    required this.review_count,
    required this.camera_level,
    required this.fly_level,
    required this.isLike,
    required this.onChange,
    this.backgroundColor = Colors.white,
    this.onTap,
  });

  String? imageUrl;
  String name;
  String address;

  int like_count;
  int review_count;
  int camera_level;
  int fly_level;

  int id;

  bool isLike;

  Color backgroundColor;

  Function()? onTap;

  ValueChanged<LikeChangeValue> onChange;

  @override
  State<StatefulWidget> createState() => _DroneSpotItemState();
}

class _DroneSpotItemState extends State<DroneSpotItem> {
  late final AuthController _authController;

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          height: 152,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: widget.backgroundColor,
          ),
          child: Row(
            children: [
              if (widget.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    height: double.infinity,
                    width: 110,
                    fit: BoxFit.cover,
                    imageUrl: HttpBase.baseUrl + widget.imageUrl!,
                  ),
                )
              else
                Container(
                  height: double.infinity,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(widget.id + 4353453)
                      )
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
                              widget.name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (widget.isLike) {
                                bool? result = await DroneSpotHttp.unlikeDronespot(_authController, id: widget.id);

                                if (result == null || !result) {
                                  return;
                                }
                                setState(() {
                                  widget.isLike = false;
                                  widget.like_count -= 1;
                                  widget.onChange(LikeChangeValue(
                                      isLike: widget.isLike,
                                      likeCount: widget.like_count
                                  ));
                                });
                              } else {
                                bool? result = await DroneSpotHttp.likeDronespot(_authController, id: widget.id);

                                if (result == null || !result) {
                                  return;
                                }
                                setState(() {
                                  widget.isLike = true;
                                  widget.like_count += 1;
                                  widget.onChange(LikeChangeValue(
                                      isLike: widget.isLike,
                                      likeCount: widget.like_count
                                  ));
                                });
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: widget.isLike ?
                                  Color(0xFF0075FF) : Colors.black38,
                                  size: 16,
                                ),
                                SizedBox(width: 2,),
                                Text(
                                  '${widget.like_count}',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 6,),
                      getFlyPermitWidget(widget.fly_level),
                      SizedBox(height: 2,),
                      getPicturePermitWidget(widget.camera_level),
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
                          Expanded(
                            child: Text(
                              widget.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4,),
                      Text(
                        '리뷰 ${widget.review_count}',
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