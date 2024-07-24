import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final PageController _pageController;

  int _pageIdx = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _pageIdx
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _createTermPage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 0, 24, getBottomPaddingWithHeight(context, 24)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                Text('sss'),
                Text('sss')
              ],
            ),
          ),
          SizedBox(
            height: 44,
            width: double.infinity,
            child: MainButton(
              onPressed: () {
                _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn
                );
                setState(() {
                  _pageIdx = 1;
                });
              },
              childText: '다음'
            ),
          )
        ],
      )
    );
  }

  Widget _createInformationPage() {
    return Container(
      child: Text('info'),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (_pageIdx == 0) {
      title = '약관 동의';
    } else if (_pageIdx == 1) {
      title = '가입하기';
    }
    return Scaffold(
      appBar: CustomAppbar(
        title: title,
        textColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            // Get.back();
            if (_pageIdx == 0) {
              Get.back();
            } else if (_pageIdx == 1) {
              _pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn
              );
              setState(() {
                _pageIdx = 0;
              });
            }
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _createTermPage(),
            _createInformationPage()
          ],
        ),
      ),
    );
  }
}
