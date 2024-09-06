import 'package:dravel/api/http_dronespot.dart';
import 'package:dravel/model/model_dronespot.dart';
import 'package:dravel/utils/util_ui.dart';
import 'package:dravel/widgets/list/list_item_search.dart';
import 'package:dravel/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DroneSpotSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DroneSpotSearchPageState();
}

class _DroneSpotSearchPageState extends State<DroneSpotSearchPage> {
  late final SharedPreferences _sharedPreferences;
  late final TextEditingController _searchController;

  List<String> _recentKeyword = [];
  List<TrendDronrspot> _trendKeyword = [];

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _recentKeyword = _sharedPreferences.getStringList('search') ?? [];
    if (mounted) setState(() {});
  }

  Future<void> _initTrend() async {
    final result = await DroneSpotHttp.getTrendDronespot();
    if (result == null) return;

    _trendKeyword = result;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _initSharedPreferences();
    _initTrend();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              controller: _searchController,
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
              onEditingComplete: () async {
                final String text = _searchController.text;
                if (text.isEmpty) return;

                _recentKeyword.insert(0, text);
                if (_recentKeyword.length > 10) _recentKeyword.removeAt(_recentKeyword.length - 1);
                await _sharedPreferences.setStringList('search', _recentKeyword);
                setState(() {});
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
          if (_recentKeyword.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, idx) {
                return SearchKeywordListItem(
                  mode: SearchKeywordListItem.MODE_RECENT_KEYWORD,
                  name: _recentKeyword[idx],
                  onTap: () {

                  },
                );
              },
              separatorBuilder: (context, idx) {
                return SizedBox(height: 12,);
              },
              itemCount: _recentKeyword.length
            )
          else
            NoDataWidget()
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
            '가장 많이 찾고 있어요',
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
                name: _trendKeyword[idx].name,
                num: idx + 1,
                onTap: () {

                },
              );
            },
            separatorBuilder: (context, idx) {
              return SizedBox(height: 12,);
            },
            itemCount: _trendKeyword.length
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
                    _createTrendKeywordSection(),
                    SizedBox(height: getBottomPaddingWithSafeHeight(context, 24),)
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
