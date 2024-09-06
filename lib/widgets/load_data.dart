import 'package:flutter/material.dart';

class LoadDataWidget extends StatelessWidget {
  LoadDataWidget({
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
          CircularProgressIndicator(),
          SizedBox(height: 8,),
          Text(text ?? "데이터 로딩중...")
        ],
      ),
    );
  }
}