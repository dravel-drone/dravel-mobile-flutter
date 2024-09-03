import 'dart:io';

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
  @override
  State<StatefulWidget> createState() => _CommentWritePageState();
}

class _CommentWritePageState extends State<CommentWritePage> {
  DateTime _selectedDate = DateTime.now();
  List<XFile> _selectedImages = [];

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
                  _selectedImages.add(result!);
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
                onPressed: () {

                },
                childText: '리뷰 등록'
            ),
          ),
        ],
      ),
    );
  }
}
