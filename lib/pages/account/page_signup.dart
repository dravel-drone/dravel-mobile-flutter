import 'package:dravel/api/http_auth.dart';
import 'package:dravel/api/http_term.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/model/model_term.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/button/button_term.dart';
import 'package:dravel/widgets/dropdown/dropdown_main.dart';
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

  late final TextEditingController _nicknameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordReController;
  late final TextEditingController _droneController;

  final List<String> _ageList = <String>[
    '선택안함', '10대 미만', '10대', '20대', '30대', '40대', '50대', '60대 이상'];
  int _selectedAge = 0;

  int _pageIdx = 0;

  int isLoaded = 0;

  late final List<TermModel> _termData;
  Map<int, dynamic> _termAgreement = {};

  Future<void> initData() async {
    List<TermModel>? data = await TermHttp.getAllTermData();
    if (data == null) {
      isLoaded = -1;
    } else {
      _termData = data;
      for (var i in _termData) {
        _termAgreement[i.id] = {
          "required": i.required,
          "isAgree": false
        };
      }
      isLoaded = 1;
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    initData();
    _pageController = PageController(
      initialPage: _pageIdx
    );

    _nicknameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordReFocusNode = FocusNode();
    _droneFocusNode = FocusNode();

    _nicknameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordReController = TextEditingController();
    _droneController = TextEditingController();
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

    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordReController.dispose();
    _droneController.dispose();
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
              children: List.generate(_termData.length, (idx) => TermAgreementButton(
                isChecked: _termAgreement[_termData[idx].id]['isAgree']!,
                isRequired: _termData[idx].required,
                name: _termData[idx].title,
                content: _termData[idx].content,
                onChanged: (value) {
                  _termAgreement[_termData[idx].id]['isAgree'] = value;
                },
              )),
            ),
          ),
          SizedBox(
            height: 44,
            width: double.infinity,
            child: MainButton(
              onPressed: () {
                for (var i in _termAgreement.keys) {
                  if (!_termAgreement[i]['required']) continue;
                  if (!_termAgreement[i]['isAgree']) {
                    if (Get.isSnackbarOpen) Get.back();
                    Get.showSnackbar(
                      GetSnackBar(
                        message: '필수 약관을 동의해 주세요.',
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                      )
                    );
                    return;
                  }
                }
                _pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeIn
                );
                debugPrint(_termAgreement.toString());
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
                    controller: _nicknameController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
                    obscureText: true,
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
                    controller: _passwordReController,
                    obscureText: true,
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
                    controller: _droneController,
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
                  ),
                  SizedBox(height: 24,),
                  Text('나이 (선택)'),
                  SizedBox(height: 8,),
                  MainDropDown(
                    value: _selectedAge,
                    items: List.generate(_ageList.length, (i) => DropdownMenuItem(
                      value: i,
                      child: Text(_ageList[i]),
                    )),
                    onChanged: (value) {
                      debugPrint(value.toString());
                      setState(() {
                        _selectedAge = value!;
                      });
                    }
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
              onPressed: () async {
                final nickname = _nicknameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;
                final passwordRe = _passwordReController.text;
                final drone = _droneController.text;
                final age = _selectedAge;
                if (nickname.isEmpty || email.isEmpty || password.isEmpty || passwordRe.isEmpty) {
                  if (Get.isSnackbarOpen) Get.back();
                  Get.showSnackbar(
                    GetSnackBar(
                      message: "모든 필수 칸을 채워주세요.",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    )
                  );
                  return;
                }

                if (password != passwordRe) {
                  if (Get.isSnackbarOpen) Get.back();
                  Get.showSnackbar(
                      GetSnackBar(
                        message: "비밀번호가 다릅니다.",
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                      )
                  );
                  return;
                }

                List<int> selectedTerm = [];
                for (var k in _termAgreement.keys) {
                  if (_termAgreement[k]['isAgree']) selectedTerm.add(k);
                }
                RegisterModel registerModel = RegisterModel(
                  name: nickname,
                  id: email,
                  email: email,
                  password: password,
                  drone: drone.isEmpty ? null : drone,
                  age: age,
                  agreeTerm: selectedTerm
                );

                if (Get.isSnackbarOpen) Get.back();
                Get.dialog(
                  AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 12,),
                        Text('회원가입 처리중..')
                      ],
                    ),
                    buttonPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.fromLTRB(18, 24, 18, 24),
                  ),
                  barrierDismissible: false
                );
                bool result = await AuthHttp.registerUser(registerModel);
                Get.back();
                if (result) {
                  Get.back();
                  Get.showSnackbar(
                    GetSnackBar(
                      message: "회원가입 성공. 로그인 해주세요.",
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 2),
                    )
                  );
                } else {
                  Get.back();
                  Get.showSnackbar(
                    GetSnackBar(
                      message: "회원가입 과정에서 오류가 발생했습니다. 다시 시도해주세요.",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    )
                  );
                }
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

    Widget child;
    if (isLoaded == 0) {
      child = const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12,),
            Text("데이터 로드중...")
          ],
        ),
      );
    } else if (isLoaded == 1) {
      child = SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _createTermPage(),
            _createInformationPage()
          ],
        ),
      );
    } else {
      child = const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48,),
            SizedBox(height: 12,),
            Text("에러 발생\n다시 시도해주세요.", textAlign: TextAlign.center,)
          ],
        ),
      );
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
      body: child,
    );
  }
}
