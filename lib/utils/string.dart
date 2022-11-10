import 'package:flutter/services.dart';

extension StringUtils on String {
  Future<void> copyToClipboard() {
    return Clipboard.setData(ClipboardData(text: this));
  }
  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeEach => split(" ").map((str) => str.capitalizeFirst).join(" ");
  String get splitUnderScore => replaceAll("_", " ");
}

extension ToString on int {
  String get ordinal => 
    this % 10 == 1 && this != 11 ? '${this}st' :
    this % 10 == 2 && this != 12 ? '${this}nd' :
    this % 10 == 3 && this != 13 ? '${this}rd' :
    '${this}th';
}