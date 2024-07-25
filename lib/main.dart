import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/pages/page_main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard'
      ),
      home: MainNavigationPage(),
    );
  }
}
