import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/models/task_reminder_time_before_due.dart';
import 'package:tasca/models/task_reminder_type.dart';
import 'package:tasca/widgets/task_reminder_before_due_setter_view.dart';
import 'package:tasca/widgets/task_schedule_setter_view.dart';
import 'package:dart_date/dart_date.dart';

class TaskReminderSetterView extends StatelessWidget {
  static const reminderTypesOptions = {
    TaskReminderType.whenDue: 'When due',
    TaskReminderType.beforeDue: 'Before due',
    TaskReminderType.custom: 'Custom'
  };
  static const reminderTypes = [
    TaskReminderType.whenDue,
    TaskReminderType.beforeDue,
    TaskReminderType.custom
  ];

  final TaskReminder reminder;
  final void Function(TaskReminder) onSet;

  TaskReminderSetterView(
      {Key? key, required this.reminder, required this.onSet})
      : super(key: key);

  _handleReminderTypeChange(TaskReminderType value) {
    late TaskReminder reminder;
    switch (value) {
      case TaskReminderType.whenDue:
        reminder = TaskReminder.whenDue;
        break;
      case TaskReminderType.beforeDue:
        reminder = TaskReminder.timeBeforeDue(TaskReminderTimeBeforeDue(
            15, TaskReminderTimeBeforeDueUnit.minute));
        break;
      case TaskReminderType.custom:
        reminder = TaskReminder.custom((DateTimeSchedule()
          ..start = TaskDateTime.fromDateTime(DateTime.now().addHours(1))));
        break;
    }
    onSet(reminder);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return Column(
        children: [
          DropdownButton<TaskReminderType>(
              value: reminder.type,
              items: reminderTypes
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(reminderTypesOptions[item]!),
                      ))
                  .toList(),
              onChanged: (value) => _handleReminderTypeChange(value!)),
          if (reminder.type == TaskReminderType.custom)
            TaskScheduleSetterView(
                onSet: (schedule) {
                  reminder.customSchedule = schedule;
                  onSet(reminder);
                },
                schedule: reminder.customSchedule!),
          if (reminder.type == TaskReminderType.beforeDue)
            TaskReminderBeforeDueSetterView(
                timeBeforeDue: reminder.timeBeforeDue!,
                onSet: (timeBeforeDue) {
                  reminder.timeBeforeDue = timeBeforeDue;
                  onSet(reminder);
                })
        ],
      );
    });
  }
}
