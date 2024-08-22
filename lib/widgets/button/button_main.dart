import 'package:flutter/material.dart';

class MainButton extends ElevatedButton {
  MainButton({
    required super.onPressed,
    required String childText,
    super.key,
  }) : super(
    child: Text(
      childText,
    ),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF4285F4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    )
  );
}