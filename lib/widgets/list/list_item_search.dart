import 'package:flutter/material.dart';

class SearchKeywordListItem extends StatelessWidget {
  static const bool MODE_RECENT_KEYWORD = false;
  static const bool MODE_TEAND_KEYWORD = false;

  SearchKeywordListItem({
    required this.mode,
    required this.name,
    required this.onTap,
    this.num = -1,
  });

  bool mode;
  int num;
  String name;

  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 44,
        decoration: BoxDecoration(
            color: Color(0xFFF1F1F5),
            borderRadius: BorderRadius.circular(8)
        ),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(200)
              ),
              width: 24,
              height: 24,
              child: Center(
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}