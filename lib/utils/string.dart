import 'package:flutter/services.dart';

extension StringUtils on String {
  Future<void> copyToClipboard() {
    return Clipboard.setData(ClipboardData(text: this));
  }
  /// a string => A string
  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';
  /// a string => A String
  String get capitalizeEach => split(" ").map((str) => str.capitalizeFirst).join(" ");
  /// "apple_orange" => "apple orange"
  String get splitUnderScore => replaceAll("_", " ");
}

extension ToString on int {
  /// 1st, 2nd, 3rd, ...
  String get ordinal => 
    this % 10 == 1 && this != 11 ? '${this}st' :
    this % 10 == 2 && this != 12 ? '${this}nd' :
    this % 10 == 3 && this != 13 ? '${this}rd' :
    '${this}th';
}