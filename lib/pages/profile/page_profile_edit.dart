import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  XFile? _pickedImage;

  Future<void> _getProfileImage() async {
    final ImagePicker picker = ImagePicker();
    _pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (_pickedImage == null) {
      return;
    }
    setState(() {});
  }

  Widget _createEditSection() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: _pickedImage == null ? CachedNetworkImage(
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, obj) {
                    return Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(457848)
                          )
                      ),
                    );
                  },
                  imageUrl: "https://images.unsplash.com/photo-1498141321056-776a06214e24?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ) :
                Image.file(
                  File(_pickedImage!.path),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
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
                      _getProfileImage();
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 24,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('닉네임'),
          ),
          SizedBox(height: 8,),
          MainTextField(
            hintText: '닉네임',
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black45,
            ),
            action: TextInputAction.done,
            onEditingComplete: () {
              debugPrint("next");
              FocusScope.of(context).unfocus();
            },
          ),
          SizedBox(height: 24,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('한줄소개'),
          ),
          SizedBox(height: 8,),
          MainTextField(
            hintText: '한줄소개',
            prefixIcon: Icon(
              Icons.person,
              color: Colors.black45,
            ),
            action: TextInputAction.done,
            onEditingComplete: () {
              debugPrint("next");
              FocusScope.of(context).unfocus();
            },
          ),
          SizedBox(height: 24,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('보유 드론 (선택)'),
          ),
          SizedBox(height: 8,),
          MainTextField(
            hintText: '드론 이름',
            prefixIcon: Icon(
              Icons.flight_outlined,
              color: Colors.black45,
            ),
            action: TextInputAction.done,
            onEditingComplete: () {
              debugPrint("next");
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }

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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(24, 0, 24, getBottomPaddingWithHeight(context, 24)),
          child: Column(
            children: [
              Expanded(
                child: _createEditSection(),
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: MainButton(
                    onPressed: () {

                    },
                    childText: '저장'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
