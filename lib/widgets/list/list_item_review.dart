import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_review.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/dialog/dialog_report_ask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/page_profile.dart';

class LikeChangeValue {
  int likeCount;
  bool isLike;

  LikeChangeValue({
    required this.likeCount,
    required this.isLike
  });
}

class ReviewRecommendItem extends StatefulWidget {
  ReviewRecommendItem({
    required this.img,
    required this.name,
    required this.writerUid,
    required this.place,
    required this.content,
    required this.likeCount,
    required this.id,
    required this.onChange,
    this.isLike = false
  });

  String? img;
  String? name;
  String place;
  String content;

  String? writerUid;

  int likeCount;
  bool isLike;

  int id;

  ValueChanged<LikeChangeValue> onChange;

  @override
  State<StatefulWidget> createState() => _ReviewRecommendItemState();
}

class _ReviewRecommendItemState extends State<ReviewRecommendItem> {
  late final AuthController _authController;
  bool mode = false;

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
        onTap: () {
          setState(() {
            mode = !mode;
          });
        },
        onLongPress: () async {
          bool? result = await showAskDialog(
            context: context,
            message: '\'${widget.name}\'님의 리뷰를 신고하시겠습니까?',
            title: '리뷰 신고',
            allowText: '신고'
          );

          if (result == null || !result) return;

          Get.dialog(
            AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 24,),
                  Text(
                    '리뷰 신고중..',
                    style: TextStyle(
                        height: 1
                    ),
                  )
                ],
              ),
              actionsPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
            ),
            barrierDismissible: false
          );

          int? apiResult = await ReviewHttp.reportReview(_authController, id: widget.id);

          bool? isDialogOpen = Get.isDialogOpen;
          if (isDialogOpen != null && isDialogOpen) Get.back();

          if (apiResult == null) {
            if (Get.isSnackbarOpen) Get.back();
            Get.showSnackbar(
              GetSnackBar(
                message: '오류가 발생했습니다. 다시 시도해주세요.',
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              )
            );
          } else if (apiResult == 0) {
            if (Get.isSnackbarOpen) Get.back();
            Get.showSnackbar(
                GetSnackBar(
                  message: '이미 신고한 리뷰입니다.',
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                )
            );
          } else {
            if (Get.isSnackbarOpen) Get.back();
            Get.showSnackbar(
                GetSnackBar(
                  message: '신고가 완료되었습니다.',
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 1),
                )
            );
          }
        },
        child: !mode ? Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Color(0xFFF1F1F5),
          ),
          child: Row(
            children: [
              if (widget.img != null)
                CachedNetworkImage(
                  imageUrl: HttpBase.baseUrl + widget.img!,
                  errorWidget: (context, error, obj) {
                    return Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(widget.id + 43564745)
                          )
                      ),
                    );
                  },
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  width: 100,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(widget.id + 43564745)
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
                            child: GestureDetector(
                              onTap: () {
                                if (widget.writerUid == null) {
                                  if (Get.isSnackbarOpen) Get.back();
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      message: '탈퇴한 사용자입니다.',
                                      duration: Duration(seconds: 1),
                                      backgroundColor: Colors.orange,
                                    )
                                  );
                                  return;
                                }
                                Get.to(() => ProfilePage(
                                  pageMode: true,
                                  uid: widget.writerUid,
                                ));
                              },
                              child: Text(
                                widget.name ?? '탈퇴한 사용자',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF0075FF)
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (widget.isLike) {
                                bool? result = await ReviewHttp.unlikeReview(_authController, id: widget.id);

                                if (result == null || !result) {
                                  return;
                                }
                                setState(() {
                                  widget.isLike = false;
                                  widget.likeCount -= 1;
                                  widget.onChange(LikeChangeValue(
                                      isLike: widget.isLike,
                                      likeCount: widget.likeCount
                                  ));
                                });
                              } else {
                                bool? result = await ReviewHttp.likeReview(_authController, id: widget.id);

                                if (result == null || !result) {
                                  return;
                                }
                                setState(() {
                                  widget.isLike = true;
                                  widget.likeCount += 1;
                                  widget.onChange(LikeChangeValue(
                                      isLike: widget.isLike,
                                      likeCount: widget.likeCount
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
                      Expanded(
                        child: Text(
                          widget.content,
                          // key: _secondChildKey,
                          style: TextStyle(
                              color: Colors.black54
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ) : Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Color(0xFFF1F1F5),
          ),
          child: Column(
            children: [
              if (widget.img != null)
                CachedNetworkImage(
                  imageUrl: HttpBase.baseUrl + widget.img!,
                  errorWidget: (context, error, obj) {
                    return Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(widget.id + 43564745)
                          )
                      ),
                    );
                  },
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(widget.id + 43564745)
                      )
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 12, 18, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (widget.writerUid == null) {
                            if (Get.isSnackbarOpen) Get.back();
                            Get.showSnackbar(
                                GetSnackBar(
                                  message: '탈퇴한 사용자입니다.',
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.orange,
                                )
                            );
                            return;
                          }
                          Get.to(() => ProfilePage(
                            pageMode: true,
                            uid: widget.writerUid,
                          ));
                        },
                        child: Text(
                          widget.name ?? '탈퇴한 사용자',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0075FF)
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (widget.isLike) {
                          bool? result = await ReviewHttp.unlikeReview(_authController, id: widget.id);

                          if (result == null || !result) {
                            return;
                          }
                          setState(() {
                            widget.isLike = false;
                            widget.likeCount -= 1;
                            widget.onChange(LikeChangeValue(
                                isLike: widget.isLike,
                                likeCount: widget.likeCount
                            ));
                          });
                        } else {
                          bool? result = await ReviewHttp.likeReview(_authController, id: widget.id);

                          if (result == null || !result) {
                            return;
                          }
                          setState(() {
                            widget.isLike = true;
                            widget.likeCount += 1;
                            widget.onChange(LikeChangeValue(
                                isLike: widget.isLike,
                                likeCount: widget.likeCount
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
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Text(
                  widget.place,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(18, 6, 19, 18),
                width: double.infinity,
                child: Text(
                  widget.content,
                  style: TextStyle(
                      color: Colors.black54
                  ),
                  softWrap: true,
                  maxLines: null,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class ReviewFullItem extends StatefulWidget {
  ReviewFullItem({
    this.img,
    this.name,
    required this.id,
    required this.writerUid,
    required this.place,
    required this.content,
    required this.likeCount,
    required this.drone,
    required this.date,
    required this.onChange,
    this.isLike = false
  });

  String? img;
  String? name;
  String place;
  String content;
  String drone;
  String date;

  String? writerUid;

  bool isLike;

  int likeCount;
  int id;

  ValueChanged<LikeChangeValue> onChange;

  @override
  State<StatefulWidget> createState() => _ReviewFullItemState();
}

class _ReviewFullItemState extends State<ReviewFullItem> {
  late final AuthController _authController;

  bool mode = false;

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
        onTap: () {
          setState(() {
            mode = !mode;
          });
        },
        onLongPress: () async {
          bool? result = await showAskDialog(
              context: context,
              message: '\'${widget.name}\'님의 리뷰를 신고하시겠습니까?',
              title: '리뷰 신고',
              allowText: '신고'
          );

          if (result == null || !result) return;

          Get.dialog(
              AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 24,),
                    Text(
                      '리뷰 신고중..',
                      style: TextStyle(
                          height: 1
                      ),
                    )
                  ],
                ),
                actionsPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
              ),
              barrierDismissible: false
          );

          int? apiResult = await ReviewHttp.reportReview(_authController, id: widget.id);

          bool? isDialogOpen = Get.isDialogOpen;
          if (isDialogOpen != null && isDialogOpen) Get.back();

          if (apiResult == null) {
            if (Get.isSnackbarOpen) Get.back();
            Get.showSnackbar(
                GetSnackBar(
                  message: '오류가 발생했습니다. 다시 시도해주세요.',
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 1),
                )
            );
          } else if (apiResult == 0) {
            if (Get.isSnackbarOpen) Get.back();
            Get.showSnackbar(
                GetSnackBar(
                  message: '이미 신고한 리뷰입니다.',
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 1),
                )
            );
          } else {
            if (Get.isSnackbarOpen) Get.back();
            Get.showSnackbar(
                GetSnackBar(
                  message: '신고가 완료되었습니다.',
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 1),
                )
            );
          }
        },
        child: !mode ? Container(
          width: double.infinity,
          height: 180,
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
                      height: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(widget.id + 43564745)
                          )
                      ),
                    );
                  },
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  width: 100,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(widget.id + 43564745)
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
                            child: GestureDetector(
                              onTap: () {
                                if (widget.writerUid == null) {
                                  if (Get.isSnackbarOpen) Get.back();
                                  Get.showSnackbar(
                                      GetSnackBar(
                                        message: '탈퇴한 사용자입니다.',
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.orange,
                                      )
                                  );
                                  return;
                                }
                                Get.to(() => ProfilePage(
                                  pageMode: true,
                                  uid: widget.writerUid,
                                ));
                              },
                              child: Text(
                                widget.name ?? '탈퇴한 사용자',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF0075FF)
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (widget.isLike) {
                                bool? result = await ReviewHttp.unlikeReview(_authController, id: widget.id);

                                if (result == null || !result) {
                                  if (Get.isSnackbarOpen) Get.back();
                                  Get.showSnackbar(
                                    GetSnackBar(
                                      backgroundColor: Colors.red,
                                      message: "좋아요 과정에서 오류가 발생했습니다.",
                                      duration: Duration(seconds: 1),
                                    )
                                  );
                                  return;
                                }
                                setState(() {
                                  widget.isLike = false;
                                  widget.likeCount -= 1;
                                  widget.onChange(LikeChangeValue(
                                      isLike: widget.isLike,
                                      likeCount: widget.likeCount
                                  ));
                                });
                              } else {
                                bool? result = await ReviewHttp.likeReview(_authController, id: widget.id);

                                if (result == null || !result) {
                                  if (Get.isSnackbarOpen) Get.back();
                                  Get.showSnackbar(
                                      GetSnackBar(
                                        backgroundColor: Colors.red,
                                        message: "좋아요 과정에서 오류가 발생했습니다.",
                                        duration: Duration(seconds: 1),
                                      )
                                  );
                                  return;
                                }
                                setState(() {
                                  widget.isLike = true;
                                  widget.likeCount += 1;
                                  widget.onChange(LikeChangeValue(
                                      isLike: widget.isLike,
                                      likeCount: widget.likeCount
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.content,
                            style: TextStyle(
                                color: Colors.black54
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
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
        ) : Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        child: Column(
          children: [
            if (widget.img != null)
              CachedNetworkImage(
                imageUrl: HttpBase.baseUrl + widget.img!,
                errorWidget: (context, error, obj) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: getRandomGradientColor(widget.id + 43564745)
                        )
                    ),
                  );
                },
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: getRandomGradientColor(widget.id + 43564745)
                    )
                ),
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(18, 12, 18, 6),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (widget.writerUid == null) {
                          if (Get.isSnackbarOpen) Get.back();
                          Get.showSnackbar(
                              GetSnackBar(
                                message: '탈퇴한 사용자입니다.',
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.orange,
                              )
                          );
                          return;
                        }
                        Get.to(() => ProfilePage(
                          pageMode: true,
                          uid: widget.writerUid,
                        ));
                      },
                      child: Text(
                        widget.name ?? '탈퇴한 사용자',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0075FF)
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (widget.isLike) {
                        bool? result = await ReviewHttp.unlikeReview(_authController, id: widget.id);

                        if (result == null || !result) {
                          return;
                        }
                        setState(() {
                          widget.isLike = false;
                          widget.likeCount -= 1;
                          widget.onChange(LikeChangeValue(
                              isLike: widget.isLike,
                              likeCount: widget.likeCount
                          ));
                        });
                      } else {
                        bool? result = await ReviewHttp.likeReview(_authController, id: widget.id);

                        if (result == null || !result) {
                          return;
                        }
                        setState(() {
                          widget.isLike = true;
                          widget.likeCount += 1;
                          widget.onChange(LikeChangeValue(
                              isLike: widget.isLike,
                              likeCount: widget.likeCount
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
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Text(
                widget.place,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 6, 19, 18),
              width: double.infinity,
              child: Text(
                widget.content,
                style: TextStyle(
                  color: Colors.black54
                ),
                softWrap: true,
                maxLines: null,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: Row(
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
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}