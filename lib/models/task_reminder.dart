import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';
import 'package:dart_date/dart_date.dart';
import 'package:tasca/models/task_reminder_time_before_due.dart';
import 'package:tasca/models/task_reminder_type.dart';

part 'task_reminder.g.dart';

@JsonSerializable()
class TaskReminder {
  static TaskReminder whenDue = TaskReminder()..type = TaskReminderType.whenDue;

  TaskReminder.timeBeforeDue(this.timeBeforeDue) {
    type = TaskReminderType.beforeDue;
  }
  TaskReminder.custom(this.customSchedule) {
    type = TaskReminderType.custom;
  }
  TaskReminder();

  late TaskReminderType type;
  TaskReminderTimeBeforeDue? timeBeforeDue;
  DateTimeSchedule? customSchedule;

  @override
  String toString() {
    if (type == TaskReminderType.whenDue) {
      return 'When due';
    } else if (type == TaskReminderType.beforeDue) {
      final value = timeBeforeDue!.value;
      final unit = timeBeforeDue!.unit;
      final unitSingular = unit.toString().split('.').last;
      final unitPlural = '${unitSingular}s';
      final unitString =
          Intl.plural(value, other: unitPlural, one: unitSingular);
      return '${value} ${unitString} before due';
    } else {
      return customSchedule!.getRangeString();
    }
  }

  factory TaskReminder.fromJson(Map<String, dynamic> json) =>
      _$TaskReminderFromJson(json);
  Map<String, dynamic> toJson() => _$TaskReminderToJson(this);
}
