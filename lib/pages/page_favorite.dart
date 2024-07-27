import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this
    );
    super.initState();
  }

  Widget _createAppbar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.grey.shade200,
            statusBarBrightness: SystemUiOverlayStyle.dark.statusBarBrightness,
            statusBarIconBrightness: SystemUiOverlayStyle.dark.statusBarIconBrightness,
            systemStatusBarContrastEnforced: SystemUiOverlayStyle.dark.systemStatusBarContrastEnforced,
          ),
          child: Material(
            color: Colors.grey.shade200,
            child: Semantics(
              explicitChildNodes: true,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '좋아요',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TabBar(
                      controller: _tabController,
                      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black54,
                      labelPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                      labelColor: Color(0xFF0075FF),
                      indicatorColor: Color(0xFF0075FF),
                      onTap: (index) {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                      tabs: const [
                        Tab(text: "드론스팟"),
                        Tab(text: "리뷰"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget _createDroneSpotLikeSection() {
    return Container(
      child: Text('drone'),
    );
  }

  Widget _createReviewLikeSection() {
    return Container(
      child: Text('review'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? child;
    switch(_selectedTab) {
      case 0:
        child = _createDroneSpotLikeSection();
        break;
      case 1:
        child = _createReviewLikeSection();
        break;
    }

    return SafeArea(
      top: false,
      child: Column(
        children: [
          _createAppbar(),
          child!
        ],
      ),
    );
  }
}
