import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  Widget _createAppbar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0xFFF1F1F5),
            statusBarBrightness: SystemUiOverlayStyle.dark.statusBarBrightness,
            statusBarIconBrightness: SystemUiOverlayStyle.dark.statusBarIconBrightness,
            systemStatusBarContrastEnforced: SystemUiOverlayStyle.dark.systemStatusBarContrastEnforced,
          ),
          child: Material(
            color: Color(0xFFF1F1F5),
            child: Semantics(
              explicitChildNodes: true,
              child: CustomAppbar(
                backgroundColor: Color(0xFFF1F1F5),
                title: "계정 이름",
                textColor: Colors.black,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    // Get.back();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.bookmark_border_rounded),
                    onPressed: () {
                      // Get.back();
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          _createAppbar()
        ],
      ),
    );
  }
}
