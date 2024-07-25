import 'package:flutter/material.dart';

double getBottomPaddingWithHeight(BuildContext context, double bottomPadding) {
  double bottomHeight = MediaQuery.of(context).padding.bottom;
  debugPrint('$bottomHeight');
  if (bottomHeight == 0) return bottomPadding;
  return 0;
}

double getTopPaddingWithHeight(BuildContext context, double topPadding) {
  double topHeight = MediaQuery.of(context).padding.top;
  debugPrint('$topHeight');
  if (topHeight == 0) return topPadding;
  return 0;
}
