import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/l10n.dart';

export 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  static final _chineseWeekDay = ["一", "二", "三", "四", "五", "六", "日"];
  static final weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  /// ["一", "二", "三", "四", "五", "六", "日"]
  String get chineseWeekDay => _chineseWeekDay[weekday - 1];

  String get chineseWeekDayLong => "星期${_chineseWeekDay[weekday - 1]}";

  /// Get String from date, for example: "2022-1-1 (六)"
  String get dateString => "$year-$month-$day ($chineseWeekDay)";

  String get dateStringChinese => "$year年$month月$day日";

  /// Get String "HH:mm" from DateTime
  String get timeString => DateFormat('HH:mm').format(this);

  /// Get readable String from DateTime, for example: "2022-1-1 (六) 00:00"
  String get dateTimeString => "$dateString $timeString";

  /// Get the first millisecond of the day, for example: 2022-01-01T12:30.000Z -> 2022-01-01T00:00.000Z
  DateTime get startOfTheDay => DateTime(year, month, day);

  /// Get the first millisecond of the day, for example: 2022-01-01T12:30.000Z -> 2022-01-01T23:59.999Z
  DateTime get endOfTheDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Convert DateTime to timeOfDay. Shorthand for `TimeOfDay.fromDateTime(this)`.
  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(this);

  String get greeting => timeOfDay.greeting;

  static final today = DateTime.now().startOfTheDay;
}

extension DateTimeRangeFormat on DateTimeRange {
  get display => "${start.timeString}-${end.timeString}";
}

extension TimeFormat on TimeOfDay {
  /// Convert from int. [number] should indicate how many minutes since 00:00.
  static TimeOfDay? fromInt(int? number) {
    if (number == null) return null;
    return TimeOfDay(hour: number ~/ 60, minute: number.remainder(60));
  }

  String get greeting => hour > 3 && hour < 12
      ? S.current.greeting_morning
      : hour < 16
          ? S.current.greeting_afternoon
          : hour < 20
              ? S.current.greeting_evening
              : S.current.greeting_night;

  /// Convert to Int. Returns as how many minutes since 00:00.
  int toInt() => hour * 60 + minute;

  String get display => "$hour:$minute";
}

extension DurationFormat on Duration {
  static Duration parse(String input) {
    var hours = 0;
    var minutes = 0;
    int micros;
    var parts = input.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
