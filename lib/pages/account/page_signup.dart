import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/button/button_term.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final PageController _pageController;

  late final FocusNode _nicknameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _passwordReFocusNode;
  late final FocusNode _droneFocusNode;

  int _pageIdx = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _pageIdx
    );

    _nicknameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordReFocusNode = FocusNode();
    _droneFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    _nicknameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordReFocusNode.dispose();
    _droneFocusNode.dispose();
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
                TermAgreementButton(
                  isRequired: false,
                  isChecked: true,
                  name: '개인정보처리방침',
                  content: '내용입니다.',
                ),
                TermAgreementButton(
                  isRequired: true,
                  isChecked: false,
                  name: '푸시알림동의',
                  content: '내용입니다.',
                ),
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
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 0, 24, getBottomPaddingWithHeight(context, 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('닉네임'),
                  SizedBox(height: 8,),
                  MainTextField(
                    hintText: '닉네임',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black45,
                    ),
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      debugPrint("next");
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    focusNode: _nicknameFocusNode,
                  ),
                  SizedBox(height: 24,),
                  Text('이메일'),
                  SizedBox(height: 8,),
                  MainTextField(
                    hintText: '이메일',
                    prefixIcon: Icon(
                      Icons.mail_rounded,
                      color: Colors.black45,
                    ),
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      debugPrint("next");
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    focusNode: _emailFocusNode,
                  ),
                  SizedBox(height: 24,),
                  Text('비밀번호'),
                  SizedBox(height: 8,),
                  MainTextField(
                    hintText: '비밀번호',
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: Colors.black45,
                    ),
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      debugPrint("next");
                      FocusScope.of(context).requestFocus(_passwordReFocusNode);
                    },
                    focusNode: _passwordFocusNode,
                  ),
                  SizedBox(height: 24,),
                  Text('비밀번호 확인'),
                  SizedBox(height: 8,),
                  MainTextField(
                    hintText: '비밀번호 재입력',
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: Colors.black45,
                    ),
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      debugPrint("next");
                      FocusScope.of(context).requestFocus(_droneFocusNode);
                    },
                    focusNode: _passwordReFocusNode,
                  ),
                  SizedBox(height: 24,),
                  Text('보유 드론 (선택)'),
                  SizedBox(height: 8,),
                  MainTextField(
                    hintText: '드론 이름',
                    prefixIcon: Icon(
                      Icons.flight_outlined,
                      color: Colors.black45,
                    ),
                    action: TextInputAction.done,
                    onEditingComplete: () {
                      debugPrint("next");
                      FocusScope.of(context).unfocus();
                    },
                    focusNode: _droneFocusNode,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8,),
          SizedBox(
            height: 44,
            width: double.infinity,
            child: MainButton(
                onPressed: () {

                },
                childText: '회원가입'
            ),
          )
        ],
      )
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
              _nicknameFocusNode.unfocus();
              _emailFocusNode.unfocus();
              _passwordFocusNode.unfocus();
              _passwordReFocusNode.unfocus();
              _droneFocusNode.unfocus();
              FocusScope.of(context).unfocus();
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
