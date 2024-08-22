import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/list/list_item_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DroneSpotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DroneSpotSearchPageState();
}

class _DroneSpotSearchPageState extends State<DroneSpotSearchPage> {

  List<Map<String, dynamic>> _recentKeyword = [
    {
      "name": "성산일출봉",
    },
    {
      "name": "한라산",
    },
    {
      "name": "우도",
    },
  ];

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
  
  Widget _createRecentKeywordSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '최근 검색어',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1
            ),
          ),
          SizedBox(height: 12,),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, idx) {
              return SearchKeywordListItem(
                mode: SearchKeywordListItem.MODE_RECENT_KEYWORD,
                name: _recentKeyword[idx]['name'],
                onTap: () {

                },
              );
            },
            separatorBuilder: (context, idx) {
              return SizedBox(height: 12,);
            },
            itemCount: _recentKeyword.length
          )
        ],
      ),
    );
  }

  Widget _createTrendKeywordSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '가장 많이 검색하고 있어요',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1
            ),
          ),
          SizedBox(height: 12,),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, idx) {
              return SearchKeywordListItem(
                mode: SearchKeywordListItem.MODE_TEAND_KEYWORD,
                name: _recentKeyword[idx]['name'],
                num: idx + 1,
                onTap: () {

                },
              );
            },
            separatorBuilder: (context, idx) {
              return SizedBox(height: 12,);
            },
            itemCount: _recentKeyword.length
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
            _createSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 24,),
                    _createRecentKeywordSection(),
                    SizedBox(height: 24,),
                    _createTrendKeywordSection()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
