import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/pages/account/page_signup.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthController _authController;

  late final FlutterSecureStorage _secureStorage;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isSaveEmail = false;
  bool _obscurePassword = true;

  Future<void> initData() async {
    String? saveEmail = await _secureStorage.read(key: 'saveEmail');
    if (saveEmail != null) {
      _isSaveEmail = saveEmail == 'true';
    }

    String? email = await _secureStorage.read(key: 'email');
    if (email != null) {
      _emailController.text = email;
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _authController = Get.find<AuthController>();

    _secureStorage = FlutterSecureStorage();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    initData();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _createTextInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이메일'),
        SizedBox(height: 8,),
        MainTextField(
          controller: _emailController,
          hintText: '이메일',
          prefixIcon: Icon(
            Icons.mail_rounded,
            color: Colors.black45,
          )
        ),
        SizedBox(height: 24,),
        Text('비밀번호'),
        SizedBox(height: 8,),
        MainTextField(
          controller: _passwordController,
          hintText: '비밀번호',
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Colors.black45,
          ),
          obscureText: _obscurePassword,
          suffixWidget: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: Icon(
              _obscurePassword ?
                Icons.visibility_outlined :Icons.visibility_off_outlined,
              color: Colors.black45,
            ),
          ),
        ),
        SizedBox(height: 24,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      activeColor: Color(0xFF4285F4),
                      value: _isSaveEmail,
                      onChanged: (value) async {
                        if (value == null) return;

                        _isSaveEmail = value;
                        await _secureStorage.write(
                          key: 'saveEmail',
                          value: _isSaveEmail ? 'true' : 'false');
                        setState(() {});
                      }
                    ),
                  ),
                  SizedBox(width: 8,),
                  Text(
                    "아이디 저장",
                    style: TextStyle(
                        color: Colors.black54,
                        height: 1
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {

              },
              child: Text(
                '아이디/비밀번호 찾기',
                style: TextStyle(
                  color: Colors.black54,
                  height: 1
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "로그인",
        textColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_outlined),
        //   onPressed: () {
        //     Get.back();
        //   },
        // ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 35, 24, 24),
          width: double.infinity,
          child: Column(
            children: [
              _createTextInputSection(),
              SizedBox(height: 48,),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: MainButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    if (email.isEmpty || password.isEmpty) {
                      if (Get.isSnackbarOpen) Get.back();
                      Get.showSnackbar(
                        GetSnackBar(
                          message: '모든 칸을 채워주세요.',
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                        )
                      );
                      return;
                    }

                    if (Get.isSnackbarOpen) Get.back();
                    Get.dialog(
                        const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 12,),
                              Text('로그인중..')
                            ],
                          ),
                          buttonPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.fromLTRB(18, 24, 18, 24),
                        ),
                        barrierDismissible: false
                    );
                    bool result = await _authController.login(
                      LoginModel(
                        id: email,
                        password: password
                      )
                    );
                    Get.back();

                    if (!result) {
                      if (Get.isSnackbarOpen) Get.back();
                      Get.showSnackbar(
                          const GetSnackBar(
                            message: "로그인 실패. 다시 시도해주세요.",
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          )
                      );
                      return;
                    }
                    // _secureStorage.write(key: 'access', value: value)
                    // _secureStorage.write(key: 'refresh', value: value)

                    if (_isSaveEmail) {
                      _secureStorage.write(
                        key: 'email',
                        value: email);
                    } else {
                      _secureStorage.delete(key: 'email');
                    }
                  },
                  childText: '로그인',
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '아직 회원이 아니신가요?',
                        style: TextStyle(
                          color: Colors.black54
                        ),
                      ),
                      SizedBox(width: 4,),
                      InkWell(
                        onTap: () {
                          Get.to(() => SignUpPage());
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
