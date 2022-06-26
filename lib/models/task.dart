import 'package:clock/clock.dart';
import 'package:tasca/models/index.dart';
import 'package:dart_date/dart_date.dart';
import 'package:tasca/models/task_reminder_time_before_due.dart';
import 'package:tasca/models/task_reminder_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/time_of_day_json_converter.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String? id;
  String? description;
  List<DateTimeSchedule> schedules = [];
  List<TaskReminder> reminders = [];
  bool isComplete = false;
  DateTime? lastRemindTime;

  Task();

  TaskDateTime? getNextDueTime() {
    TaskDateTime? earliestFuture;
    for (final schedule in schedules) {
      final start = schedule.start;
      TaskDateTime? future;
      if (schedule.isRepeating) {
        future = schedule.getNextFutureTime();
      } else if (!start.dateTime!.isPast) {
        future = start;
      }
      if (earliestFuture == null ||
          (future?.dateTime?.isBefore(earliestFuture.dateTime!) ?? false)) {
        earliestFuture = future;
      }
    }
    return earliestFuture;
  }

  TaskDateTime? getDueTime() {
    TaskDateTime? earliest;
    for (final schedule in schedules) {
      final start = schedule.start;
      final dateTime = start.dateTime!;
      if (earliest == null || dateTime.isBefore(earliest.dateTime!)) {
        earliest = start;
      }
    }
    return earliest?.clone();
  }

  DateTime? getReminderTime(TaskReminder reminder) {
    final dueTime = getDueTime()?.dateTime;
    switch (reminder.type) {
      case TaskReminderType.whenDue:
        return dueTime;
      case TaskReminderType.beforeDue:
        if (dueTime == null) {
          return null;
        }
        final value = reminder.timeBeforeDue!.value;
        return {
          TaskReminderTimeBeforeDueUnit.minute: dueTime.subMinutes(value),
          TaskReminderTimeBeforeDueUnit.day: dueTime.subDays(value),
          TaskReminderTimeBeforeDueUnit.hour: dueTime.subHours(value),
          TaskReminderTimeBeforeDueUnit.week: dueTime.subDays(value * 7),
          TaskReminderTimeBeforeDueUnit.month: dueTime.subMonths(value),
          TaskReminderTimeBeforeDueUnit.year: dueTime.subYears(value)
        }[reminder.timeBeforeDue!.unit]!;
      case TaskReminderType.custom:
        return reminder.customSchedule!.start.dateTime;
    }
  }

  DateTime? getNextRemindTime() {
    DateTime? earliest;
    for (final reminder in reminders) {
      final remindTime = getReminderTime(reminder);
      if (remindTime != null) {
        if (earliest == null ||
            (remindTime.isBefore(earliest) && !remindTime.isPast)) {
          earliest = remindTime;
        }
      }
    }
    return earliest;
  }

  TaskReminder? getNextReminder() {
    DateTime? earliestTime;
    TaskReminder? earliest;
    for (final reminder in reminders) {
      final remindTime = getReminderTime(reminder);
      if (remindTime != null) {
        if (earliestTime == null ||
            (remindTime.isBefore(earliestTime) && !remindTime.isPast)) {
          earliestTime = remindTime;
          earliest = reminder;
        }
      }
    }
    return earliest;
  }

  void hasReminded() {
    lastRemindTime = clock.now();
  }

  bool get isPlanned {
    return schedules.isNotEmpty;
  }

  bool isReminderDue() {
    final nextRemindTime = getNextRemindTime();
    if (nextRemindTime == null) {
      return false;
    } else {
      return (!clock.now().isBefore(nextRemindTime)) &&
          (lastRemindTime?.isBefore(clock.now()) ?? true);
    }
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
