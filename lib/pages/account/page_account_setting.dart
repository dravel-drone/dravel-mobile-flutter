import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/dialog/dialog_report_ask.dart';

class AccountSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  late final AuthController _authController;

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    super.initState();
  }

  Widget _settingItem({
    required Icon icon,
    required String text,
    required Function() onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: TextStyle(
                  height: 1
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: '계정 설정',
        backgroundColor: Colors.white,
        textColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12,),
            _settingItem(
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ),
              text: '로그아웃',
              onTap: () async {
                bool? result = await showAskDialog(
                  context: context,
                  message: '로그아웃 하시겠습니까?',
                  title: '로그아웃',
                  allowText: '로그아웃',
                );

                if (result == null || !result) return;

                _authController.logout();
              }
            ),
            SizedBox(
              height: getBottomPaddingWithSafeHeight(context, 24),
            )
          ],
        ),
      )
    );
  }
}
