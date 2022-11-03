import 'package:flutter/material.dart';
extension Validation on TextEditingController {
  bool get isValidPassword => text.length >= 8 && text.length <= 16 &&
  text.contains(RegExp(r'[a-zA-Z]')) &&
  text.contains(RegExp(r'[0-9]'));

  bool get isEmail => RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(text);

  bool get isBlank => text == "";
}
