import 'package:flutter/services.dart';

extension StringUtils on String {
  Future<void> copyToClipboard() {
    return Clipboard.setData(ClipboardData(text: this));
  }
}
