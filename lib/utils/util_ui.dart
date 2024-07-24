import 'package:flutter/material.dart';

double getBottomPaddingWithHeight(BuildContext context, double bottomPadding) {
  double bottomHeight = MediaQuery.of(context).padding.bottom;
  debugPrint('$bottomHeight');
  if (bottomHeight == 0) return bottomPadding;
  return 0;
}