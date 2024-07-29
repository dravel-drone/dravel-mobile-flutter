import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/list/list_item_dronespot.dart';
import 'package:dravel/widgets/list/list_item_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _droneSpotController;
  late final ScrollController _reviewController;
  late final ScrollController _nestedController;

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
    _tabController = TabController(length: 2, vsync: this);
    _reviewController = ScrollController();
    _droneSpotController = ScrollController();
    _nestedController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewController.dispose();
    _droneSpotController.dispose();
    _nestedController.dispose();
    super.dispose();
  }

  Widget _createAppbar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        "계정 이름",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_outlined),
        onPressed: () {
          // Get.back();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_border_rounded),
          onPressed: () {
            // Get.back();
          },
        )
      ],
    );
  }

  Widget _createProfileInfoText({
    required String name,
    required String value
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          name,
          style: TextStyle(
              height: 1,
              color: Colors.black87,
              fontSize: 14
          ),
        )
      ],
    );
  }

  Widget _createProfileSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: CachedNetworkImage(
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  imageUrl: "https://images.unsplash.com/photo-1498141321056-776a06214e24?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: _createProfileInfoText(
                              name: '게시물',
                              value: '6'
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: _createProfileInfoText(
                                name: '팔로워',
                                value: '120'
                            )
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: _createProfileInfoText(
                                name: '팔로잉',
                                value: '390'
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Text(
                      '한줄 소개',
                      style: TextStyle(
                          height: 1,
                          color: Colors.black,
                          fontSize: 14
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '프론트엔드 개발자, 여행 블로거',
                      style: TextStyle(
                          height: 1,
                          color: Colors.black54
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '대표 드론 - DJI 매빅 4 PRO',
                      style: TextStyle(
                          height: 1,
                          color: Colors.black54
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 34,
            decoration: BoxDecoration(
              color: Color(0xFFF1F1F5),
              borderRadius: BorderRadius.circular(12)
            ),
            child: GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 7, 18, 7),
                child: Center(
                  child: Text(
                    '프로필 편집',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      height: 1
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _createTabbar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        splashBorderRadius: BorderRadius.circular(12),
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Color(0xFF0075FF),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        tabs: [
          Tab(
              text: '게시물'
          ),
          Tab(
              text: '드론스팟'
          )
        ],
      ),
    );
  }

  Widget _createPostList() {
    return ListView.separated(
        key: PageStorageKey('review_profile'),
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        // controller: _reviewController,
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

  Widget _createDroneSpotList() {
    return ListView.separated(
        key: PageStorageKey('drone_profile'),
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        // controller: _droneSpotController,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: NestedScrollView(
        controller: _nestedController,
        headerSliverBuilder: (context, value) {
          return [
            _createAppbar(),
            SliverPersistentHeader(
              pinned: false,
              delegate: _SliverAppBarTabDelegate(
                  child: _createProfileSection(),
                  minHeight: 180,
                  maxHeight: 180
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarTabDelegate(
                  child: _createTabbar(),
                  minHeight: 40,
                  maxHeight: 40
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _createPostList(),
            _createDroneSpotList()
          ],
        ),
      )
    );
  }
}

class _SliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarTabDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarTabDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
