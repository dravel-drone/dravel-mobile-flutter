import 'package:flutter/material.dart';

class MainTextField extends TextFormField {
  MainTextField({
    Function()? onEditingComplete,
    FocusNode? focusNode,
    Icon? prefixIcon,
    String? hintText,
    TextInputAction action = TextInputAction.done,
    Color backgroundColor = const Color(0x334285F4),
    bool obscureText = false,
    int? maxLength,
    String? Function(String?)? validator,
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
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(12)
        )
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
            Radius.circular(12)
        )
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: Colors.red
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12)
        )
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.red
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12)
        )
      ),
      prefixIcon: prefixIcon,
    ),
    validator: validator,
    autovalidateMode: AutovalidateMode.always,
    onEditingComplete: onEditingComplete,
    focusNode: focusNode
  );
}