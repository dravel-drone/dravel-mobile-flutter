import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/pages/comment/page_comment_write.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/button/button_switch.dart';
import 'package:dravel/widgets/error_data.dart';
import 'package:dravel/widgets/list/list_item_course.dart';
import 'package:dravel/widgets/list/list_item_place.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:dravel/widgets/load_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DroneSpotDetailPage extends StatefulWidget {
  DroneSpotDetailPage({
    required this.id
  });

  int id;

  @override
  State<StatefulWidget> createState() => _DroneSpotDetailPageState();
}

class _DroneSpotDetailPageState extends State<DroneSpotDetailPage> {
  
  late DronespotDetailModel _data;
  late final AuthController _authController;

  int _selectedPlaceMode = 0;
  int _loadDronespot = -1;


  Future<void> _getSpotData() async {
    final result = await DroneSpotHttp.getDronespotDetial(_authController, id: widget.id);

    if (result != null) {
      _data = result;
      _loadDronespot = 1;
      debugPrint(result.name);
    } else {
      _loadDronespot = 0;
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _getSpotData();
    super.initState();
  }

  Widget _createInfoSection() {
    Widget photo;
    if (_data.imageUrl != null) {
      photo = CachedNetworkImage(
        height: 120,
        width: 120,
        errorWidget: (context, error, obj) {
          return Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: getRandomGradientColor(widget.id + 305952)
                )
            ),
          );
        },
        imageUrl: HttpBase.baseUrl + _data.imageUrl!,
        fit: BoxFit.cover,
      );
    } else {
      photo = Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: getRandomGradientColor(_data.id + 74353))),
      );
    }

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: photo,
        ),
        SizedBox(width: 14,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '센서드론',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_data.isLike) {
                        bool? result = await DroneSpotHttp.unlikeDronespot(_authController, id: widget.id);

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
                          _data.isLike = false;
                          _data.likeCount -= 1;
                        });
                      } else {
                        bool? result = await DroneSpotHttp.likeDronespot(_authController, id: widget.id);

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
                          _data.isLike = true;
                          _data.likeCount += 1;
                        });
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: _data.isLike ?
                          Color(0xFF0075FF) : Colors.black38,
                          size: 16,
                        ),
                        SizedBox(width: 2,),
                        Text(
                          '${_data.likeCount}',
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
                '사전합의구역',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),
              getFlyPermitWidget(_data.permit.flight,
              style: TextStyle(
                color: Colors.black54
              )),
              SizedBox(height: 2,),
              getPicturePermitWidget(_data.permit.camera,
              style: TextStyle(
                  color: Colors.black54
              )),
              if (_data.location.address != null)
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
                        _data.location.address!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54
                        ),
                      ),
                    )
                  ],
                ),
              Text(
                '현재 12도 / 맑음',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _createReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '최근 리뷰',
                style: TextStyle(
                  height: 1,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: Text(
                '더보기 >',
                style: TextStyle(
                  color: Colors.black38,
                  height: 1
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 12,),
        if (_data.reviews.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, idx) {
              return ReviewFullItem(
                id: _data.reviews[idx].id,
                img: _data.reviews[idx].photoUrl,
                name: _data.reviews[idx].writer?.name,
                writerUid: _data.reviews[idx].writer?.uid,
                place: _data.reviews[idx].placeName,
                content: _data.reviews[idx].comment,
                likeCount: _data.reviews[idx].likeCount,
                drone: _data.reviews[idx].drone,
                date: _data.reviews[idx].date,
                isLike: _data.reviews[idx].isLike,
                onChange: (value) {
                  _data.reviews[idx].isLike = value.isLike;
                  _data.reviews[idx].likeCount = value.likeCount;
                },
              );;
            },
            separatorBuilder: (context, idx) {
              return SizedBox(height: 12,);
            },
            itemCount: _data.reviews.length
          )
        else
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    size: 38,
                    color: Colors.black38,
                  ),
                  SizedBox(height: 8,),
                  Text("아직 리뷰가 없습니다.", style: TextStyle(
                    height: 1,
                    color: Colors.black38
                  ),)
                ],
              ),
            ),
          ),
        SizedBox(height: 12,),
        SizedBox(
          width: double.infinity,
          child: MainButton(
              onPressed: () {
                Get.to(() => CommentWritePage(
                  dronespotId: widget.id,
                ))?.then((v) {
                  _getSpotData();
                });
              },
              childText: '리뷰 작성하기'
          ),
        )
      ],
    );
  }

  Widget _createCourseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '추천 코스',
                style: TextStyle(
                    height: 1,
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //
            //   },
            //   child: Text(
            //     '더보기 >',
            //     style: TextStyle(
            //         color: Colors.black38,
            //         height: 1
            //     ),
            //   ),
            // )
          ],
        ),
        SizedBox(height: 12,),
        if (_data.courses.isNotEmpty)
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, idx) {
                return CourseItem(
                  img: _data.courses[idx].photoUrl,
                  id: _data.courses[idx].id,
                  name: _data.courses[idx].name,
                  distance: _data.courses[idx].distance,
                  duration: _data.courses[idx].duration,
                  sectionColor: Colors.white
                );
              },
              separatorBuilder: (context, idx) {
                return SizedBox(height: 12,);
              },
              itemCount: _data.courses.length
          )
        else
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    size: 38,
                    color: Colors.black38,
                  ),
                  SizedBox(height: 8,),
                  Text("아직 추천 코스가 없습니다.", style: TextStyle(
                      height: 1,
                      color: Colors.black38
                  ),)
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _createPlaceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '근처 추천 장소',
                style: TextStyle(
                    height: 1,
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            SwitchButton(
              items: [
                "숙소", "맛집"
              ],
              height: 34,
              onChange: (value) {
                print(value);
                setState(() {
                  _selectedPlaceMode = value;
                });
              },
            )
          ],
        ),
        SizedBox(height: 12,),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, idx) {
              String key = 'accommodation';
              if (_selectedPlaceMode == 1) {
                return PlaceItem(
                  id: _data.places.restaurants[idx].id,
                  name: _data.places.restaurants[idx].name,
                  location: PlaceLocation(
                      lat: _data.places.restaurants[idx].location.lat,
                      lng: _data.places.restaurants[idx].location.lon
                  ),
                  message: _data.places.restaurants[idx].comment,
                  imageUrl: _data.places.restaurants[idx].photoUrl,
                  address: _data.places.restaurants[idx].location.address!,
                );
              } else {
                return PlaceItem(
                  id: _data.places.accommodations[idx].id,
                  name: _data.places.accommodations[idx].name,
                  location: PlaceLocation(
                      lat: _data.places.restaurants[idx].location.lat,
                      lng: _data.places.restaurants[idx].location.lon
                  ),
                  message: _data.places.accommodations[idx].comment,
                  imageUrl: _data.places.accommodations[idx].photoUrl,
                  address: _data.places.accommodations[idx].location.address!,
                );
              }
            },
            separatorBuilder: (context, idx) {
              return SizedBox(height: 12,);
            },
            itemCount: _selectedPlaceMode == 0 ?
              _data.places.accommodations.length : _data.places.restaurants.length
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loadDronespot != 1) {
      Widget body;
      if (_loadDronespot == -1) {
        body = LoadDataWidget();
      } else {
        body = ErrorDataWidget();
      }
      
      return Scaffold(
        backgroundColor: Color(0xFFF1F1F5),
        appBar: CustomAppbar(
          title: "",
          textColor: Colors.black,
          backgroundColor: Color(0xFFF1F1F5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(38),
          width: double.infinity,
          height: double.infinity,
          child: body,
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      appBar: CustomAppbar(
        title: _data.name,
        textColor: Colors.black,
        backgroundColor: Color(0xFFF1F1F5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createInfoSection(),
              SizedBox(height: 24,),
              _createReviewSection(),
              SizedBox(height: 24,),
              _createCourseSection(),
              SizedBox(height: 24,),
              _createPlaceSection(),
              SizedBox(
                height: getBottomPaddingWithSafeHeight(context, 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
