import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDropDown extends DropdownButtonFormField<int> {
  MainDropDown({
    required int value,
    required List<DropdownMenuItem<int>> items,
    ValueChanged<int?>? onChanged,
    super.key
  }) : super(
    decoration: const InputDecoration(
      filled: true,
      fillColor: Color(0x334285F4),
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
    ),
    value: value,
    items: items,
    onChanged: onChanged
  );
}