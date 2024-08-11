import 'package:dravel/widgets/appbar/appbar_main.dart';
import 'package:dravel/widgets/button/button_switch.dart';
import 'package:dravel/widgets/textField/textfield_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentWritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommentWritePageState();
}

class _CommentWritePageState extends State<CommentWritePage> {
  DateTime _selectedDate = DateTime.now();

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
              SizedBox(height: 18,),
              _createCheckAvailableSection(),
              SizedBox(height: 32,),
              _createUsingDroneSection(),
              SizedBox(height: 32,),
              _createDateSection()
            ],
          ),
        ),
      ),
    );
  }
}
