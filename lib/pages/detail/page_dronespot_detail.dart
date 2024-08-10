import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DroneSpotDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DroneSpotDetailPageState();
}

class _DroneSpotDetailPageState extends State<DroneSpotDetailPage> {

  Widget _createInfoSection() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            height: 110,
            width: 110,
            fit: BoxFit.cover,
            imageUrl: 'https://images.unsplash.com/photo-1500531279542-fc8490c8ea4d?q=80&w=1742&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      appBar: CustomAppbar(
        title: "장소이름",
        textColor: Colors.black,
        backgroundColor: Color(0xFFF1F1F5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 0, 24, getBottomPaddingWithSafeHeight(context, 24)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createInfoSection()
            ],
          ),
        ),
      ),
    );
  }
}
