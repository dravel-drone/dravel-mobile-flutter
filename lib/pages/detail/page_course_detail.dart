import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/api/http_course.dart';
import 'package:dravel/model/model_course.dart';
import 'package:dravel/model/model_place.dart';
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
  List<String> _images = [];

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

        } else {

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
                items: List.generate(_images.length, (idx) => CachedNetworkImage(
                  imageUrl: _images[idx],
                  fit: BoxFit.cover,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  color: Color(0x40000000),
                  colorBlendMode: BlendMode.darken,
                )),
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
            '2개의 경유지 / 8.2km / 4시간 30분',
            style: TextStyle(
              height: 1,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 12,),
          Text(
            '''모든 국민은 신체의 자유를 가진다. 누구든지 법률에 의하지 아니하고는 체포·구속·압수·수색 또는 심문을 받지 아니하며, 법률과 적법한 절차에 의하지 아니하고는 처벌·보안처분 또는 강제노역을 받지 아니한다. 법률은 특별한 규정이 없는 한 공포한 날로부터 20일을 경과함으로써 효력을 발생한다.

모든 국민은 신속한 재판을 받을 권리를 가진다. 형사피고인은 상당한 이유가 없는 한 지체없이 공개재판을 받을 권리를 가진다. 국가는 농·어민과 중소기업의 자조조직을 육성하여야 하며, 그 자율적 활동과 발전을 보장한다. 의원을 제명하려면 국회재적의원 3분의 2 이상의 찬성이 있어야 한다. 대통령은 법률에서 구체적으로 범위를 정하여 위임받은 사항과 법률을 집행하기 위하여 필요한 사항에 관하여 대통령령을 발할 수 있다.''',
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
        if (_placeData[idx]['type'] == 0) {
          child = DroneSpotItem(
            id: 1,
            name: _placeData[idx]['name'],
            imageUrl: _placeData[idx]['img'],
            address: _placeData[idx]['address'],
            like_count: _placeData[idx]['like_count'],
            review_count: _placeData[idx]['review_count'],
            camera_level: _placeData[idx]['camera'],
            fly_level: _placeData[idx]['flight'],
            backgroundColor: Color(0xFFF1F1F5),
            isLike: false,
            onChange: (value) {

            },
          );
        } else {
          child = PlaceItem(
            id: 3,
            name: _placeData[idx]['name'],
            distance: _placeData[idx]['distance'],
            message: _placeData[idx]['message'],
            imageUrl: _placeData[idx]['img'],
            address: _placeData[idx]['location'],
            backgroundColor: Color(0xFFF1F1F5),
          );
        }
        String text = '${idx + 1}번째 경유지';
        if (idx == 0) text = '출발지';
        if (idx == _placeData.length - 1) text = '마무리';
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
      itemCount: _placeData.length
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
                  "코스 이름",
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