import 'package:flutter/material.dart';

class ErrorDataWidget extends StatelessWidget {
  ErrorDataWidget({
    this.text
  });

  String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, size: 48,),
          SizedBox(height: 12,),
          Text(text ?? "오류가 발생했습니다. 다시 시도해주세요.")
        ],
      ),
    );
  }
}