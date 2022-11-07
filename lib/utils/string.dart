import 'package:flutter/services.dart';

extension StringUtils on String {
  Future<void> copyToClipboard() {
    return Clipboard.setData(ClipboardData(text: this));
  }
  String get capitalizeFirst => '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeEach => this.split(" ").map((str) => str.capitalizeFirst).join(" ");
  String get splitUnderScore => this.replaceAll("_", " ");
}
