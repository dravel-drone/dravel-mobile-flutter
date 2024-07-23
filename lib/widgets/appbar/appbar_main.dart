import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({
    required this.title,
    this.leading,
    this.actions = const [],
    this.backgroundColor,
    this.surfaceTintColor,
    this.textColor
  });

  String title;

  Widget? leading;
  List<Widget> actions;

  Color? backgroundColor;
  Color? surfaceTintColor;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    textColor ??= Colors.white;

    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: surfaceTintColor,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor!
        ),
      ),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}