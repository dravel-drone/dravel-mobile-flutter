import 'dart:io';

import 'package:dravel/api/http_review.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/model/model_review.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_main.dart';
import 'package:dravel/widgets/button/button_switch.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CommentWritePage extends StatefulWidget {
  CommentWritePage({
    required this.dronespotId
  });

  int dronespotId;

  @override
  State<StatefulWidget> createState() => _CommentWritePageState();
}

class _CommentWritePageState extends State<CommentWritePage> {
  late final TextEditingController _droneNameController;
  late final TextEditingController _reviewController;

  late final AuthController _authController;

  DateTime _selectedDate = DateTime.now();
  List<XFile> _selectedImages = [];

  bool _permitFlight = false;
  bool _permitCamera = false;

  @override
  void initState() {
    _authController = Get.find<AuthController>();
    _droneNameController = TextEditingController();
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _droneNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

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
                  fontSize: 18
              ),
            ),
            SizedBox(height: 12,),
            SwitchButton(
              items: [
                '○',
                'X'
              ],
              onChange: (value) {
                _permitFlight = value == 1;
              },
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
                  fontSize: 18
              ),
            ),
            SizedBox(height: 12,),
            SwitchButton(
              items: [
                '○',
                'X'
              ],
              onChange: (value) {
                _permitCamera = value == 1;
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _createUsingDroneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사용한 드론 기종",
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        SizedBox(height: 12,),
        MainTextField(
          backgroundColor: Colors.white,
          controller: _droneNameController,
          hintText: '드론 이름',
          prefixIcon: Icon(
            Icons.flight_outlined,
            color: Colors.black45,
          ),
          action: TextInputAction.done,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        )
      ],
    );
  }

  Widget _createDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "방문 일시",
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        SizedBox(height: 12,),
        GestureDetector(
          onTap: () async {
            DateTime? result = await showDatePicker(
              context: context,
              firstDate: DateTime(0, 1, 1),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              locale: const Locale("ko", "KR"),
            );
            if (result == null) return;

            setState(() {
              _selectedDate = result;
            });
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 18, 16),
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12)
              )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black54,
                ),
                SizedBox(width: 14,),
                Text(
                  DateFormat('yyy-MM-dd').format(_selectedDate),
                  style: TextStyle(
                    fontSize: 14,
                    height: 1,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _createReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "리뷰 내용",
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        SizedBox(height: 12,),
        TextField(
          maxLength: 600,
          maxLines: null,
          controller: _reviewController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: '리뷰 입력',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                    Radius.circular(12)
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                    Radius.circular(12)
                )
            ),
          ),
        )
      ],
    );
  }

  Widget _createPickPictureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사진 첨부 (선택)",
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w500,
              fontSize: 18
          ),
        ),
        SizedBox(height: 2,),
        Container(
          height: _selectedImages.length > 0 ? 72 : 0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, idx) {
              return Container(
                width: 72,
                height: 72,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Image.file(
                          File(_selectedImages[idx].path),
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImages.removeAt(idx);
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(200)
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, idx) {
              return SizedBox(width: 12,);
            },
            itemCount: _selectedImages.length
          ),
        ),
        SizedBox(height: 12,),
        Visibility(
          visible: _selectedImages.length < 1,
          child: GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              XFile? result = await picker.pickImage(
                source: ImageSource.gallery,
                maxWidth: 650,
                maxHeight: 650,
                // limit: 1 - _selectedImages.length,
              );
              if (result != null) {
                setState(() {
                  _selectedImages.add(result);
                });
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 18, 16),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(12)
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_outlined,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 14,),
                  Text(
                    '사진 첨부',
                    style: TextStyle(
                        fontSize: 14,
                        height: 1,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
          ),
        )
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  children: [
                    SizedBox(height: 18,),
                    _createCheckAvailableSection(),
                    SizedBox(height: 32,),
                    _createUsingDroneSection(),
                    SizedBox(height: 32,),
                    _createDateSection(),
                    SizedBox(height: 32,),
                    _createReviewSection(),
                    SizedBox(height: 16,),
                    _createPickPictureSection(),
                    SizedBox(height: 32,),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24, 0, 24, getBottomPaddingWithSafeHeight(context, 24)),
            child: MainButton(
                onPressed: () async {
                  String droneName = _droneNameController.text;
                  String review = _reviewController.text;

                  if (droneName.isEmpty || review.isEmpty) {
                    if (Get.isSnackbarOpen) Get.back();
                    Get.showSnackbar(
                      GetSnackBar(
                        message: '빈 칸을 모두 채워주세요.',
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
                            '댓글 추가중..',
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

                  final DronespotReviewModel? result = await ReviewHttp.addReview(
                    _authController,
                    id: widget.dronespotId,
                    data: DronespotReviewCreateModel(
                      droneType: droneName,
                      drone: droneName,
                      date: DateFormat('yyyy-MM-ddT00:00:00').format(_selectedDate),
                      comment: review,
                      permitFlight: _permitFlight ? 1 : 0,
                      permitCamera: _permitCamera ? 1 : 0,
                    ),
                    imagePath: _selectedImages.isNotEmpty ?
                      _selectedImages[0].path : null
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
                childText: '리뷰 등록'
            ),
          ),
        ],
      ),
    );
  }
}
