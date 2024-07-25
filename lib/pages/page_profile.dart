import 'package:dravel/pages/account/page_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FilledButton(onPressed: () {Get.to(() => LoginPage());}, child: Text('login page'))
        ],
      ),
    );
  }
}
