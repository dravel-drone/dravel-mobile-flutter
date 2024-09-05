import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({
    this.text,
    this.height,
    this.width,
    this.backgroundColor
  });

  String? text;
  double? height;
  double? width;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 120,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black12,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 38,
              color: Colors.black38,
            ),
            SizedBox(height: 8,),
            Text(text ?? "아직 데이터가 없습니다.",
              style: TextStyle(
                height: 1,
                color: Colors.black38
              ),
            )
          ],
        ),
      ),
    );
  }
}