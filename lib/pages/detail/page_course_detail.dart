import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailPage extends StatelessWidget {

  Widget _createAppbar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        "계정 이름",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
      ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            _createAppbar()
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 1000,
                color: Colors.green,
              ),
              Container(
                width: double.infinity,
                height: 1000,
                color: Colors.red,
              ),
            ],
          ),
        ),
      )
    );
  }
}