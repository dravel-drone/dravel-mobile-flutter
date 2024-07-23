import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Widget _textFiledEmail() => Column(
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
      )
    ],
  );

  Widget _textFiledPassword() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('비밀번호'),
      SizedBox(height: 8,),
      MainTextField(
        hintText: '비밀번호',
        prefixIcon: Icon(
          Icons.lock_rounded,
          color: Colors.black45,
        )
      )
    ],
  );

  Widget _createTextInputSection() {
    return Column(
      children: [
        _textFiledEmail(),
        SizedBox(height: 24,),
        _textFiledPassword()
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
              _createTextInputSection()
            ],
          ),
        )
      ),
    );
  }
}
