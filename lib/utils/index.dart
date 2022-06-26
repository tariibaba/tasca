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
