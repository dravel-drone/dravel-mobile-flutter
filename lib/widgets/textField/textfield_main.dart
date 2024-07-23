import 'package:flutter/material.dart';

class MainTextField extends TextField {
  MainTextField({
    Icon? prefixIcon,
    String? hintText,
    super.controller,
    super.key
  }) : super(
    decoration: InputDecoration(
      filled: true,
      fillColor: Color(0x334285F4),
      hintText: hintText,
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
      prefixIcon: prefixIcon
    ),
  );
}