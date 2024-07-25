import 'package:dravel/pages/account/page_signup.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Widget _createTextInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이메일'),
        SizedBox(height: 8,),
        MainTextField(
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
            hintText: '비밀번호',
            prefixIcon: Icon(
              Icons.lock_rounded,
              color: Colors.black45,
            )
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
                      value: true,
                      onChanged: (value) {

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
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
                  onPressed: () {

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
