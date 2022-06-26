import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';
import 'package:dart_date/dart_date.dart';

part 'date_time_schedule.g.dart';

@JsonSerializable()
class DateTimeSchedule {
  TaskDateTime start = TaskDateTime();
  TaskRepeat repeat = TaskRepeat();
  TaskDateTime end = TaskDateTime();

  String getRangeString() {
    return '$start ${end.hasValue ? ' - $end}' : ''}';
  }

  bool get isRepeating {
    return repeat.day != null || repeat.time != null;
  }

  DateTimeSchedule clone() {
    return DateTimeSchedule()
      ..start = start.clone()
      ..repeat = repeat.clone()
      ..end = end.clone();
  }

  TaskDateTime? getNextFutureTime() {
    if (start.dateTime == null) return null;
    TaskDateTime future = start;
    if (isRepeating) {
      while (future.dateTime!.isPast) {
        future = repeat.time != null
            ? future.repeatTime(repeat.time!)
            : future.repeatDay(repeat.day!);
      }
    }
    if (!future.dateTime!.isPast) return future.clone();
    return null;
  }

  void moveToNextFutureTime() {
    start = getNextFutureTime() ?? start;
  }

  DateTimeSchedule();

  factory DateTimeSchedule.fromJson(Map<String, dynamic> json) =>
      _$DateTimeScheduleFromJson(json);

  toJson() => _$DateTimeScheduleToJson(this);
}
