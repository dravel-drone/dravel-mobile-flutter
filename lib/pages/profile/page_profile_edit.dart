import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      appBar: CustomAppbar(
        title: '프로필 편집',
        textColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Color(0xFFF1F1F5),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: CachedNetworkImage(
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      imageUrl: "https://images.unsplash.com/photo-1498141321056-776a06214e24?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      width: 120,
                      height: 120,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(200),
                        onTap: () {
                          debugPrint("test");
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
