import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dravel/api/http_base.dart';
import 'package:dravel/api/http_profile.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_profile.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({
    required this.profileModel
  });

  ProfileModel profileModel;

  @override
  State<StatefulWidget> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  XFile? _pickedImage;

  late final TextEditingController _nicknameController;
  late final TextEditingController _onelinerController;
  late final TextEditingController _droneController;
  late final AuthController _authController;

  @override
  void initState() {
    _authController = Get.find<AuthController>();

    _nicknameController = TextEditingController();
    _onelinerController = TextEditingController();
    _droneController = TextEditingController();

    _nicknameController.text = widget.profileModel.name;
    if (widget.profileModel.oneLiner != null) {
      _onelinerController.text = widget.profileModel.oneLiner!;
    }
    if (widget.profileModel.drone != null) {
      _droneController.text = widget.profileModel.drone!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _onelinerController.dispose();
    _droneController.dispose();
    super.dispose();
  }

  Future<void> _getProfileImage() async {
    final ImagePicker picker = ImagePicker();
    _pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
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
                child: _pickedImage == null ? (widget.profileModel.imageUrl != null ? CachedNetworkImage(
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, obj) {
                    return Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: getRandomGradientColor(widget.profileModel.uid.hashCode)
                          )
                      ),
                    );
                  },
                  imageUrl: HttpBase.baseUrl + widget.profileModel.imageUrl!,
                ) : Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: getRandomGradientColor(widget.profileModel.uid.hashCode)
                      )
                  ),
                )) :
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
            controller: _nicknameController,
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
            controller: _onelinerController,
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
            controller: _droneController,
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
                  onPressed: () async {
                    String name = _nicknameController.text;
                    String oneLiner = _onelinerController.text;
                    String drone = _droneController.text;

                    if (name.isEmpty && oneLiner.isEmpty && drone.isEmpty && _pickedImage == null) {
                      if (Get.isSnackbarOpen) Get.back();
                      Get.showSnackbar(
                          GetSnackBar(
                            message: '최소 하나 이상의 수정사항을 추가해주세요.',
                            backgroundColor: Colors.orange,
                            duration: Duration(seconds: 1),
                          )
                      );
                      return;
                    }

                    if (Get.isSnackbarOpen) Get.back();

                    Get.dialog(
                        AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 24,),
                              Text(
                                '프로필 수정중..',
                                style: TextStyle(
                                    height: 1
                                ),
                              )
                            ],
                          ),
                          actionsPadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.fromLTRB(24, 18, 24, 18),
                        ),
                        barrierDismissible: false
                    );

                    final ProfileModel? result = await ProfileHttp.editProfile(
                      _authController,
                      uid: _authController.userUid.value!,
                      name: name,
                      drone: drone,
                      oneLiner: oneLiner,
                      imagePath: _pickedImage?.path
                    );

                    bool? isDialogOpen = Get.isDialogOpen;
                    if (isDialogOpen != null && isDialogOpen) Get.back();
                    if (result != null) {
                      Get.back();
                    } else {
                      if (Get.isSnackbarOpen) Get.back();
                      Get.showSnackbar(
                          GetSnackBar(
                            message: '오류가 발생했습니다. 다시 시도해주세요.',
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 1),
                          )
                      );
                    }
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
