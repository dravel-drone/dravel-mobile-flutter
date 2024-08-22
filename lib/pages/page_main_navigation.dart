import 'package:dravel/pages/page_favorite.dart';
import 'package:dravel/pages/page_home.dart';
import 'package:dravel/pages/page_map.dart';
import 'package:dravel/pages/page_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainNavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late PageController _pageController;
  int _selectedPageIdx = 1;

  List<Widget> _pages = [
    MapPage(),
    HomePage(),
    FavoritePage(),
    ProfilePage()
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _selectedPageIdx
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      // body: _pages[_selectedPageIdx],
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedPageIdx,
        unselectedItemColor: Colors.black,
        selectedItemColor: Color(0xFF0075FF),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.map_outlined
              ),
              label: '지도'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home_outlined
              ),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.favorite_border_outlined
              ),
              label: '관심'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.account_circle_outlined
              ),
              label: '프로필'
          ),
        ],
        onTap: (value) {
          setState(() {
            _selectedPageIdx = value;
            _pageController.jumpToPage(_selectedPageIdx);
          });
        },
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(24),
      //     topRight: Radius.circular(24)
      //   ),
      //   child:
      // ),
    );
  }
}
