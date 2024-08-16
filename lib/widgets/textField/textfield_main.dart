import 'package:flutter/material.dart';

class MainTextField extends TextField {
  MainTextField({
    Function()? onEditingComplete,
    FocusNode? focusNode,
    Icon? prefixIcon,
    String? hintText,
    TextInputAction action = TextInputAction.done,
    Color backgroundColor = const Color(0x334285F4),
    bool obscureText = false,
    int? maxLength,
    super.controller,
    super.key
  }) : super(
    obscureText: obscureText,
    maxLength: maxLength,
    textInputAction: action,
    decoration: InputDecoration(
      filled: true,
      fillColor: backgroundColor,
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
      prefixIcon: prefixIcon,
    ),
    onEditingComplete: onEditingComplete,
    focusNode: focusNode
  );
}