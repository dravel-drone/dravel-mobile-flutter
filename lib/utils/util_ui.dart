import 'dart:math';

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
  // debugPrint('$topHeight');
  return topHeight + topPadding;
}

Widget getFlyPermitWidget(int level, {
  TextStyle style = const TextStyle()
}) {
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
        message,
        style: style
      )
    ],
  );
}

Widget getPicturePermitWidget(int level, {
  TextStyle style = const TextStyle()
}) {
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
        message,
        style: style,
      )
    ],
  );
}

List<Color> getRandomGradientColor(int seed) {
  List<List<Color>> colors = [
    [
      Color(0xFF544a7d),
      Color(0xFFffd452),
    ],
    [
      Color(0xFF8E2DE2),
      Color(0xFF4A00E0),
    ],
    [
      Color(0xFF000046),
      Color(0xFF1CB5E0),
    ],
    [
      Color(0xFF00416A),
      Color(0xFFE4E5E6),
    ],
    [
      Color(0xFF8360c3),
      Color(0xFF2ebf91),
    ],
    [
      Color(0xFF4e54c8),
      Color(0xFF8f94fb),
    ],
    [
      Color(0xFFc0392b),
      Color(0xFF8e44ad),
    ],
  ];
  return colors[Random(seed).nextInt(colors.length)];
}
