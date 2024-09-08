import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_course.dart';
import 'package:dravel/model/model_course.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/model/model_place.dart';
import 'package:dravel/pages/detail/page_dronespot_detail.dart';
import 'package:dravel/utils/util_map.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/error_data.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/list/list_item_place.dart';
import 'package:dravel/widgets/load_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({
    required this.id
  });

  int id;

  @override
  State<StatefulWidget> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late final ScrollController _sliverScrollController;

  CourseDetailModel? _courseData;
  List<String?> _images = [];

  int _selectedIdx = 0;
  bool _isShrink = false;

  int _isLoaded = -1;

  Future<void> _loadData() async {
    CourseDetailModel? result = await CourseHttp.getCourseDetail(id: widget.id);

    _courseData = result;
    if (result == null) {
      _isLoaded = 0;
    } else {
      _isLoaded = 1;
      _images.clear();
      for (var place in _courseData!.places) {
        if (place is PlaceModel) {
          _images.add(place.photoUrl);
        } else if (place is DroneSpotModel) {
          _images.add(place.imageUrl);
        } else {
          _images.add(null);
        }
      }
    }

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _sliverScrollController = ScrollController();
    _sliverScrollController.addListener(() {
      setState(() {
        _isShrink = _sliverScrollController.hasClients &&
            _sliverScrollController.offset > (230 - kToolbarHeight);
      });
    });
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _sliverScrollController.dispose();
    super.dispose();
  }

  Widget _createTopImageSnapSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: CarouselSlider(
                items: List.generate(_images.length, (idx) {
                  if (_images[idx] != null) {
                    return CachedNetworkImage(
                      imageUrl: HttpBase.baseUrl + _images[idx]!,
                      fit: BoxFit.cover,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      color: Color(0x40000000),
                      colorBlendMode: BlendMode.darken,
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: getRandomGradientColor(idx + 213434)
                        )
                      ),
                    );
                  }
                }),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: constraints.maxHeight,
                  autoPlay: true,
                  onPageChanged: (idx, reason) {
                    setState(() {
                      _selectedIdx = idx;
                    });
                  }
                ),
              ),
            ),
            Positioned(
              bottom: 14,
              width: constraints.maxWidth,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  count: _images.length,
                  activeIndex: _selectedIdx,
                  effect: WormEffect(
                    activeDotColor: Color(0xFF0075FF),
                    dotColor: Colors.black38,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _createCourseTextSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_courseData!.places.length}개의 경유지 /'
                ' ${formatDistance(_courseData!.distance)} /'
                ' ${formatTimeKor(_courseData!.duration)}',
            style: TextStyle(
              height: 1,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 12,),
          Text(
            _courseData!.content,
            style: TextStyle(
              height: 1.2,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }

  Widget _createCourseList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      itemBuilder: (context, idx) {
        Widget child;
        final item = _courseData!.places[idx];
        if (item is DroneSpotModel) {
          child = DroneSpotItem(
            id: item.id,
            name: item.name,
            imageUrl: item.imageUrl,
            address: item.location.address!,
            like_count: item.likeCount,
            review_count: item.reviewCount,
            camera_level: item.permit.camera,
            fly_level: item.permit.flight,
            backgroundColor: Color(0xFFF1F1F5),
            isLike: false,
            onChange: (value) {

            },
            onTap: () {
              Get.to(() => DroneSpotDetailPage(id: item.id));
            },
          );
        } else if (item is PlaceModel) {
          child = PlaceItem(
            id: item.id,
            name: item.name,
            distance: 1,
            message: item.comment,
            imageUrl: item.photoUrl,
            address: item.location.address ?? '',
            backgroundColor: Color(0xFFF1F1F5),
          );
        } else {
          child = SizedBox();
        }
        String text = '${idx + 1}번째 경유지';
        if (idx == 0) text = '출발지';
        if (idx == _courseData!.places.length - 1) text = '마무리';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                height: 1,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 10,),
            child
          ],
        );
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 18,);
      },
      itemCount: _courseData!.places.length
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded != 1) {
      if (_isLoaded == -1) {
        return Scaffold(
          appBar: CustomAppbar(
            title: '코스 상세정보',
              textColor: Colors.black,
              leading: IconButton(
                icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black
                ),
                onPressed: () {
                  Get.back();
                },
              )
          ),
          body: LoadDataWidget(),
        );
      } else {
        return Scaffold(
          appBar: CustomAppbar(
              title: '코스 상세정보',
              textColor: Colors.black,
              leading: IconButton(
                icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black
                ),
                onPressed: () {
                  Get.back();
                },
              )
          ),
          body: ErrorDataWidget(),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _sliverScrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            surfaceTintColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: _isShrink ? Colors.black : Colors.white
              ),
              onPressed: () {
                Get.back();
              },
            ),
            expandedHeight: 230.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.fromLTRB(0,
                  getTopPaddingWithHeight(context, 16), 0, 0),
              title: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _courseData!.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _isShrink ? Colors.black : Colors.white
                  ),
                ),
              ),
              background: _createTopImageSnapSection(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _createCourseTextSection(),
                _createCourseList(),
                SizedBox(
                  height: getBottomPaddingWithSafeHeight(context, 24),
                )
              ]
            )
          )
        ],
      ),
    );
  }
}