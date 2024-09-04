import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_review.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewRecommendItem extends StatefulWidget {
  ReviewRecommendItem({
    required this.img,
    required this.name,
    required this.place,
    required this.content,
    required this.likeCount,
  });

  String img;
  String name;
  String place;
  String content;

  int likeCount;

  @override
  State<StatefulWidget> createState() => _ReviewRecommendItemState();
}

class _ReviewRecommendItemState extends State<ReviewRecommendItem> {
  late final AuthController _authController;

  final GlobalKey _secondChildKey = GlobalKey();
  double _secondChildHeight = 0;

  bool mode = false;

  @override
  void initState() {
    _authController = Get.find<AuthController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _afterLayout();
    });
    super.initState();
  }

  void _afterLayout() {
    final RenderBox renderBox = _secondChildKey.currentContext?.findRenderObject() as RenderBox;
    if (renderBox != null) {
      final height = renderBox.size.height;
      print(height);
      setState(() {
        _secondChildHeight = height + 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: () {
          setState(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _afterLayout();
            });
            mode = !mode;
          });
        },
        child: Container(
          width: double.infinity,
          height: _secondChildHeight > 0 ? _secondChildHeight : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Color(0xFFF1F1F5),
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: widget.img,
                width: 100,
                height: _secondChildHeight > 0 ? _secondChildHeight : null,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0075FF)
                              ),
                            ),
                          ),
                          // _recommendReviewTestData[idx]['is_like'] ?
                          //   Icon(
                          //     Icons.favorite,
                          //     color: Color(0xFF0075FF),
                          //     size: 16,
                          //   ) : Icon(
                          //     Icons.favorite_border,
                          //     color: Colors.black54,
                          //     size: 16,
                          //   ),
                          Icon(
                            Icons.favorite,
                            color: Color(0xFF0075FF),
                            size: 16,
                          ),
                          SizedBox(width: 2,),
                          Text(
                            '${widget.likeCount}',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14
                            ),
                          )
                        ],
                      ),
                      Text(
                        widget.place,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.content,
                        key: _secondChildKey,
                        style: TextStyle(
                            color: Colors.black54
                        ),
                        overflow: mode ? null : TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: mode ? null : 3,
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

class ReviewFullItem extends StatefulWidget {
  ReviewFullItem({
    this.img,
    this.name,
    required this.id,
    required this.place,
    required this.content,
    required this.likeCount,
    required this.drone,
    required this.date,
    this.isLike = false
  });

  String? img;
  String? name;
  String place;
  String content;
  String drone;
  String date;

  bool isLike;

  int likeCount;
  int id;

  @override
  State<StatefulWidget> createState() => _ReviewFullItemState();
}

class _ReviewFullItemState extends State<ReviewFullItem> {
  late final AuthController _authController;

  final GlobalKey _secondChildKey = GlobalKey();
  double _secondChildHeight = 0;

  bool mode = false;

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _afterLayout();
    });
    super.initState();
  }

  void _afterLayout() {
    final RenderBox renderBox = _secondChildKey.currentContext?.findRenderObject() as RenderBox;
    if (renderBox != null) {
      final height = renderBox.size.height;
      print(height);
      setState(() {
        _secondChildHeight = height + 120;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: () {
          setState(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _afterLayout();
            });
            mode = !mode;
          });
        },
        child: Container(
          width: double.infinity,
          height: _secondChildHeight > 0 ? _secondChildHeight : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          child: Row(
            children: [
              if (widget.img != null)
                CachedNetworkImage(
                  imageUrl: HttpBase.baseUrl + widget.img!,
                  errorWidget: (context, error, obj) {
                    return Container(
                      width: 100,
                      height: _secondChildHeight > 0 ? _secondChildHeight : null,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(43564745)
                          )
                      ),
                    );
                  },
                  width: 100,
                  height: _secondChildHeight > 0 ? _secondChildHeight : null,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  width: 100,
                  height: _secondChildHeight > 0 ? _secondChildHeight : null,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(43564745)
                      )
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.name ?? '탈퇴한 사용자',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0075FF)
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (widget.isLike) {
                                setState(() {
                                  widget.isLike = false;
                                });
                              } else {
                                bool? result = await ReviewHttp.likeReview(_authController, id: widget.id);

                                if (result == null || !result) {
                                  return;
                                }
                                setState(() {
                                  widget.isLike = true;
                                  widget.likeCount += 1;
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
                                  '${widget.likeCount}',
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
                      Text(
                        widget.place,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.content,
                        key: _secondChildKey,
                        style: TextStyle(
                            color: Colors.black54
                        ),
                        overflow: mode ? null : TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: mode ? null : 3,
                      ),
                      SizedBox(height: 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              widget.drone,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                height: 1,
                                fontSize: 14
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Text(
                            widget.date,
                            style: TextStyle(
                              height: 1,
                              color: Colors.black54
                            ),
                          )
                        ],
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