import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  DateTime setTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}

extension TimeOfDayExtensions on TimeOfDay {
  DateTime toDateTimeNow() {
    return DateTime.now().setTimeOfDay(this);
  }

  TimeOfDay clone() {
    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension ColorExtensions on Color {
  static Color hexWithOpacity(String hex, double opacity) {
    RegExp exp = RegExp(r"^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$");
    final match = exp.firstMatch(hex);
    final groups = match!.groups([1, 2, 3]);
    final r = int.parse(groups[0]!, radix: 16);
    final g = int.parse(groups[1]!, radix: 16);
    final b = int.parse(groups[2]!, radix: 16);
    return Color.fromRGBO(r, g, b, opacity);
  }
}
