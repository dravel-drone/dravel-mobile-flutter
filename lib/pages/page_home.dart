import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            Text(
              '여행지 탐색',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
    );
  }
}
