import 'package:dravel/utils/util_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Get.back();
              },
            ),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.fromLTRB(0,
                  getTopPaddingWithHeight(context, 16), 0, 0),
              title: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "코스 이름",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
              ),
              background: GestureDetector(
                onTap: () {
                  print('object');
                },
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 2000,
                  width: double.infinity,
                  color: Colors.red,
                ),
                Container(
                  height: 2000,
                  width: double.infinity,
                  color: Colors.green,
                ),
              ]
            )
          )
        ],
      ),
    );
  }
}