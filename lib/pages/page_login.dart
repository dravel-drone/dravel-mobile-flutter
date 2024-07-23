import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: Text("login"),
      ),
    );
  }
}
