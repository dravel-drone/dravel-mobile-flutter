import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

double getBottomPaddingWithHeight(BuildContext context, double bottomPadding) {
  double bottomHeight = MediaQuery.of(context).padding.bottom;
  debugPrint('$bottomHeight');
  if (bottomHeight == 0) return bottomPadding;
  return 0;
}

double getBottomPaddingWithSafeHeight(BuildContext context, double bottomPadding) {
  double bottomHeight = MediaQuery.of(context).padding.bottom;
  debugPrint('$bottomHeight');
  if (bottomHeight == 0) return bottomPadding;
  return bottomHeight;
}

double getTopPaddingWithHeight(BuildContext context, double topPadding) {
  double topHeight = MediaQuery.of(context).padding.top;
  debugPrint('$topHeight');
  return topHeight + topPadding;
}

Widget getFlyPermitWidget(int level) {
  String svgPath;
  String message;
  switch(level) {
    case 0: {
      svgPath = 'assets/images/icons/ban.svg';
      message = '비행 불가';
      break;
    }
    case 1: {
      svgPath = 'assets/images/icons/contect.svg';
      message = '비행 허가 필요';
      break;
    }
    default: {
      svgPath = 'assets/images/icons/allow.svg';
      message = '비행 가능';
      break;
    }
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        svgPath,
        width: 18,
        height: 18,
      ),
      SizedBox(width: 6,),
      Text(
        message
      )
    ],
  );
}

Widget getPicturePermitWidget(int level) {
  String svgPath;
  String message;
  switch(level) {
    case 0: {
      svgPath = 'assets/images/icons/ban.svg';
      message = '촬영 불가';
      break;
    }
    case 1: {
      svgPath = 'assets/images/icons/contect.svg';
      message = '촬영 허가 필요';
      break;
    }
    default: {
      svgPath = 'assets/images/icons/allow.svg';
      message = '촬영 가능';
      break;
    }
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        svgPath,
        width: 18,
        height: 18,
      ),
      SizedBox(width: 6,),
      Text(
        message
      )
    ],
  );
}
