import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _droneSpotController;
  late final ScrollController _reviewController;

  int _selectedTab = 0;

  List<dynamic> _droneLikeTestData = [
    {
      'img': 'https://images.unsplash.com/photo-1500531279542-fc8490c8ea4d?q=80&w=1742&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '거제도',
      'like_count': 234,
      'review_count': 4354,
      'flight': 0,
      'camera': 2,
      'address': '경상남도 거제시'
    },
    {
      'img': 'https://images.unsplash.com/photo-1485086806232-72035a9f951c?q=80&w=1635&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '두바이',
      'like_count': 4353,
      'review_count': 123,
      'flight': 1,
      'camera': 1,
      'address': '경상남도 두바이시'
    },
    {
      'img': 'https://images.unsplash.com/photo-1494412519320-aa613dfb7738?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '부산항',
      'like_count': 234,
      'review_count': 4354,
      'flight': 2,
      'camera': 2,
      'address': '경상남도 부산시'
    },
    {
      'img': 'https://images.unsplash.com/photo-1500531279542-fc8490c8ea4d?q=80&w=1742&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '거제도',
      'like_count': 234,
      'review_count': 4354,
      'flight': 0,
      'camera': 2,
      'address': '경상남도 거제시'
    },
    {
      'img': 'https://images.unsplash.com/photo-1485086806232-72035a9f951c?q=80&w=1635&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '두바이',
      'like_count': 4353,
      'review_count': 123,
      'flight': 1,
      'camera': 1,
      'address': '경상남도 두바이시'
    },
    {
      'img': 'https://images.unsplash.com/photo-1494412519320-aa613dfb7738?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '부산항',
      'like_count': 234,
      'review_count': 4354,
      'flight': 2,
      'camera': 2,
      'address': '경상남도 부산시'
    },
  ];


  List<dynamic> _reviewLikeTestData = [
    {
      'img': 'https://plus.unsplash.com/premium_photo-1675359655401-27e0b11bef70?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '강릉',
      'is_like': false,
      'like_count': 234,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.',
      'write_date': '2024-07-05',
      'drone': '매빅 에어2'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1664801768830-46734d0f0848?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '아늘기',
      'place': '신안',
      'is_like': true,
      'like_count': 394,
      'content': '테스트',
      'write_date': '2023-11-05',
      'drone': '매빅 미니4 PRO'
    },
    {
      'img': 'https://images.unsplash.com/photo-1465447142348-e9952c393450?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '서울',
      'is_like': false,
      'like_count': 345,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.',
      'write_date': '2024-02-17',
      'drone': '매빅 에어3'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1675359655401-27e0b11bef70?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '강릉',
      'is_like': false,
      'like_count': 234,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.',
      'write_date': '2024-07-05',
      'drone': '매빅 에어2'
    },
    {
      'img': 'https://plus.unsplash.com/premium_photo-1664801768830-46734d0f0848?q=80&w=1827&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '아늘기',
      'place': '신안',
      'is_like': true,
      'like_count': 394,
      'content': '테스트',
      'write_date': '2023-11-05',
      'drone': '매빅 미니4 PRO'
    },
    {
      'img': 'https://images.unsplash.com/photo-1465447142348-e9952c393450?q=80&w=1674&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'name': '네릳으',
      'place': '서울',
      'is_like': false,
      'like_count': 345,
      'content': '지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다. 예비비는 총액으로 국회의 의결을 얻어야 한다. 예비비의 지출은 차기국회의 승인을 얻어야 한다. 국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다.',
      'write_date': '2024-02-17',
      'drone': '매빅 에어3'
    },
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this
    );
    _reviewController = ScrollController();
    _droneSpotController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    _droneSpotController.dispose();
    super.dispose();
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
    return ListView.separated(
      key: PageStorageKey('drone'),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      controller: _droneSpotController,
      itemBuilder: (context, idx) {
        return DroneSpotItem(
          name: _droneLikeTestData[idx]['name'],
          imageUrl: _droneLikeTestData[idx]['img'],
          address: _droneLikeTestData[idx]['address'],
          like_count: _droneLikeTestData[idx]['like_count'],
          review_count: _droneLikeTestData[idx]['review_count'],
          camera_level: _droneLikeTestData[idx]['camera'],
          fly_level: _droneLikeTestData[idx]['flight']
        );
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 12,);
      },
      itemCount: _droneLikeTestData.length
    );
  }

  Widget _createReviewLikeSection() {
    return ListView.separated(
      key: PageStorageKey('review'),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      controller: _reviewController,
      itemBuilder: (context, idx) {
        return ReviewFullItem(
          img: _reviewLikeTestData[idx]['img'],
          name: _reviewLikeTestData[idx]['name'],
          place: _reviewLikeTestData[idx]['place'],
          content: _reviewLikeTestData[idx]['content'],
          likeCount: _reviewLikeTestData[idx]['like_count'],
          drone: _reviewLikeTestData[idx]['drone'],
          date: _reviewLikeTestData[idx]['write_date']
        );;
      },
      separatorBuilder: (context, idx) {
        return SizedBox(height: 12,);
      },
      itemCount: _reviewLikeTestData.length
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          _createAppbar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _createDroneSpotLikeSection(),
                _createReviewLikeSection()
              ],
            ),
          )
        ],
      ),
    );
  }
}
