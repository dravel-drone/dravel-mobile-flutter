import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CourseDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late final ScrollController _sliverScrollController;

  List<String> _images = [
    'https://plus.unsplash.com/premium_photo-1675359655401-27e0b11bef70?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1664801768830-46734d0f0848?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1695321924057-91977a88eae1?q=80&w=1750&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  int _selectedIdx = 0;
  bool _isShrink = false;

  @override
  void initState() {
    _sliverScrollController = ScrollController();
    _sliverScrollController.addListener(() {
      setState(() {
        _isShrink = _sliverScrollController.hasClients &&
            _sliverScrollController.offset > (230 - kToolbarHeight);
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _sliverScrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
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
                Container(
                  height: 2000,
                  width: double.infinity,
                  color: Colors.red,
                ),
                Container(
                  height: 2000,
                  width: double.infinity,
                  color: Colors.green,
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}