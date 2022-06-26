import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/models/task_reminder_time_before_due.dart';

class TaskReminderBeforeDueSetterView extends StatelessWidget {
  final TaskReminderTimeBeforeDue timeBeforeDue;
  final void Function(TaskReminderTimeBeforeDue) onSet;

  static const units = [
    TaskReminderTimeBeforeDueUnit.minute,
    TaskReminderTimeBeforeDueUnit.hour,
    TaskReminderTimeBeforeDueUnit.day,
    TaskReminderTimeBeforeDueUnit.month,
    TaskReminderTimeBeforeDueUnit.year
  ];

  // TODO: Clone timeBeforeDue in constructor.
  TaskReminderBeforeDueSetterView(
      {Key? key, required this.timeBeforeDue, required this.onSet})
      : super(key: key);

  TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final value = timeBeforeDue.value;
    _valueController.text = value.toString();
    return Row(
      children: [
        Expanded(
          child: Focus(
            child: TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            ),
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                if (_valueController.text.isEmpty) {
                  _valueController.text = '1';
                }
                timeBeforeDue.value = int.parse(_valueController.text);
                onSet(timeBeforeDue);
              }
            },
          ),
        ),
        DropdownButton<TaskReminderTimeBeforeDueUnit>(
            value: timeBeforeDue.unit,
            items: units.map((item) {
              final valueString = item.toString().split('.').last;
              return DropdownMenuItem<TaskReminderTimeBeforeDueUnit>(
                value: item,
                child: Text('$valueString(s)'),
              );
            }).toList(),
            onChanged: (value) {
              timeBeforeDue.unit = value!;
              onSet(timeBeforeDue);
            })
      ],
    );
  }
}
