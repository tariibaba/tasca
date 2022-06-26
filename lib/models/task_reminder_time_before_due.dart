import 'package:json_annotation/json_annotation.dart';

part 'task_reminder_time_before_due.g.dart';

@JsonSerializable()
class TaskReminderTimeBeforeDue {
  int value;
  TaskReminderTimeBeforeDueUnit unit;

  TaskReminderTimeBeforeDue(this.value, this.unit);

  factory TaskReminderTimeBeforeDue.fromJson(Map<String, dynamic> json) {
    return _$TaskReminderTimeBeforeDueFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskReminderTimeBeforeDueToJson(this);
}

enum TaskReminderTimeBeforeDueUnit { minute, hour, day, week, month, year }
