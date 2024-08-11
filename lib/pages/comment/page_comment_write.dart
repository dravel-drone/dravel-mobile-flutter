import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentWritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommentWritePageState();
}

class _CommentWritePageState extends State<CommentWritePage> {

  Widget _createCheckAvailableSection() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "비행 가능 여부",
              style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            SizedBox(height: 8,),
            SwitchButton(
              items: [
                '○',
                'X'
              ],
            )
          ],
        ),
        SizedBox(width: 24,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "촬영 가능 여부",
              style: TextStyle(
                  height: 1,
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
            ),
            SizedBox(height: 8,),
            SwitchButton(
              items: [
                '○',
                'X'
              ],
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      appBar: CustomAppbar(
        title: "리뷰 작성하기",
        textColor: Colors.black,
        backgroundColor: Color(0xFFF1F1F5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            children: [
              SizedBox(height: 12,),
              _createCheckAvailableSection()
            ],
          ),
        ),
      ),
    );
  }
}
