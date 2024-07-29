import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _createAppbar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0xFFF1F1F5),
            statusBarBrightness: SystemUiOverlayStyle.dark.statusBarBrightness,
            statusBarIconBrightness: SystemUiOverlayStyle.dark.statusBarIconBrightness,
            systemStatusBarContrastEnforced: SystemUiOverlayStyle.dark.systemStatusBarContrastEnforced,
          ),
          child: Material(
            color: Color(0xFFF1F1F5),
            child: Semantics(
              explicitChildNodes: true,
              child: CustomAppbar(
                backgroundColor: Color(0xFFF1F1F5),
                title: "계정 이름",
                textColor: Colors.black,
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
              ),
            ),
          ),
        )
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
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Row(
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
    );
  }

  Widget _createPostSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 18, 24, 0),
      child: Column(
        children: [
          Row(
            children: [
              Ink(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: InkWell(
                  onTap: () {

                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                    child: Center(
                      child: Text(
                        '프로필 편집',
                        style: TextStyle(
                            color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF0075FF),
                      ),
                      splashBorderRadius: BorderRadius.circular(12),
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
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
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          _createAppbar(),
          _createProfileSection(),
          _createPostSection()
        ],
      ),
    );
  }
}
