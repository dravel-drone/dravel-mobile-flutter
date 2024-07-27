import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReviewRecommendItem extends StatelessWidget {
  ReviewRecommendItem({
    required this.img,
    required this.name,
    required this.place,
    required this.content,
    required this.likeCount,
    this.onTap
  });

  String img;
  String name;
  String place;
  String content;

  int likeCount;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Color(0xFFF1F1F5),
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: img,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0075FF)
                              ),
                            ),
                          ),
                          // _recommendReviewTestData[idx]['is_like'] ?
                          //   Icon(
                          //     Icons.favorite,
                          //     color: Color(0xFF0075FF),
                          //     size: 16,
                          //   ) : Icon(
                          //     Icons.favorite_border,
                          //     color: Colors.black54,
                          //     size: 16,
                          //   ),
                          Icon(
                            Icons.favorite,
                            color: Color(0xFF0075FF),
                            size: 16,
                          ),
                          SizedBox(width: 2,),
                          Text(
                            '$likeCount',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14
                            ),
                          )
                        ],
                      ),
                      Text(
                        place,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            content,
                            style: TextStyle(
                                color: Colors.black54
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewFullItem extends StatelessWidget {
  ReviewFullItem({
    required this.img,
    required this.name,
    required this.place,
    required this.content,
    required this.likeCount,
    required this.drone,
    required this.date,
    this.onTap
  });

  String img;
  String name;
  String place;
  String content;
  String drone;
  String date;

  int likeCount;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: img,
                width: 100,
                height: 170,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0075FF)
                              ),
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Color(0xFF0075FF),
                            size: 16,
                          ),
                          SizedBox(width: 2,),
                          Text(
                            '$likeCount',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14
                            ),
                          )
                        ],
                      ),
                      Text(
                        place,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            content,
                            style: TextStyle(
                                color: Colors.black54
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              drone,
                              style: TextStyle(
                                height: 1,
                                fontSize: 16
                              ),
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              height: 1,
                              color: Colors.black54
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}