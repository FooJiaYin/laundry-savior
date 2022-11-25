import 'dart:convert';

import 'package:flutter/material.dart';

class ReminderConfig {
  late int remindBefore;
  String remindMethod;
  ReminderConfig({
    this.remindBefore = 0,
    required this.remindMethod,
  });

  String get summary => "$remindMethod\n${remindBefore}m before";

  static ReminderConfig get defaultConfig => ReminderConfig(remindBefore: 2, remindMethod: "Alarm");
  static const methodOptions = ["Notification", "Alarm"];

  ReminderConfig copyWith({
    int? remindBefore,
    String? remindMethod,
  }) {
    return ReminderConfig(
      remindBefore: remindBefore ?? this.remindBefore,
      remindMethod: remindMethod ?? this.remindMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'remindBefore': remindBefore,
      'remindMethod': remindMethod,
    };
  }

  factory ReminderConfig.fromMap(Map<String, dynamic> map) {
    return ReminderConfig(
      remindBefore: map['remindBefore'] as int,
      remindMethod: map['remindMethod'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReminderConfig.fromJson(String source) => ReminderConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReminderConfig(remindBefore: $remindBefore, remindMethod: $remindMethod)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReminderConfig && other.remindBefore == remindBefore && other.remindMethod == remindMethod;
  }

  @override
  int get hashCode => remindBefore.hashCode ^ remindMethod.hashCode;
}
