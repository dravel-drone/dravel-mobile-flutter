import 'package:dravel/utils/util_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DroneSpotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DroneSpotSearchPageState();
}

class _DroneSpotSearchPageState extends State<DroneSpotSearchPage> {

  Widget _createSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(200)
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Get.back();
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '드론스팟 검색어',
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
                contentPadding: EdgeInsets.fromLTRB(0, 14, 6, 14)
              ),
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                debugPrint("objecsearcht");
              },
              onTapOutside: (e) {
                FocusScope.of(context).unfocus();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F5),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, getTopPaddingWithHeight(context, 24), 24, 0),
        child: Column(
          children: [
            _createSearchBar()
          ],
        ),
      ),
    );
  }
}
