import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/models/time_of_day_json_converter.dart';
import 'package:tasca/utils/index.dart';

part 'task_date_time.g.dart';

@JsonSerializable()
@TimeOfDayJsonConverter()
class TaskDateTime {
  DateTime? date;
  TimeOfDay? time;

  TaskDateTime();

  TaskDateTime.fromDateTime(DateTime dateTime) {
    date = dateTime.setTimeOfDay(const TimeOfDay(hour: 0, minute: 0));
    time = TimeOfDay.fromDateTime(dateTime);
  }

  factory TaskDateTime.fromJson(Map<String, dynamic> json) =>
      _$TaskDateTimeFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDateTimeToJson(this);

  @override
  String toString() {
    return '${date!.format('yMMMd')}${time != null ? ' at ${(time!.toDateTimeNow().format('Hm'))}' : ''}';
  }

  TaskDateTime clone() {
    return TaskDateTime()
      ..date = date?.clone
      ..time = time?.clone();
  }

  bool get hasValue {
    return date != null || time != null;
  }

  DateTime? get dateTime {
    return date != null
        ? time != null
            ? date!.setTimeOfDay(time!)
            : date!.setTimeOfDay(const TimeOfDay(hour: 0, minute: 0))
        : null;
  }

  TaskDateTime repeatTime(TimeRepeat timeRepeat) {
    final repeatValue = timeRepeat.value!;
    final newDateTime = timeRepeat.interval == TimeRepeatInterval.hour
        ? dateTime!.addHours(repeatValue)
        : dateTime!.addMinutes(repeatValue);
    return TaskDateTime.fromDateTime(newDateTime);
  }

  TaskDateTime repeatDay(DayRepeat dayRepeat) {
    final repeatValue = dayRepeat.value!;
    final newDateTime = {
      DayRepeatInterval.day: dateTime!.addDays(repeatValue),
      DayRepeatInterval.week: dateTime!.addWeeks(repeatValue),
      DayRepeatInterval.month: dateTime!.addMonths(repeatValue),
      DayRepeatInterval.year: dateTime!.addYears(repeatValue)
    }[dayRepeat.interval!]!;
    return TaskDateTime.fromDateTime(newDateTime);
  }
}
