import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasca/models/index.dart';

import '../utils/index.dart';

class TaskScheduleSetterView extends StatelessWidget {
  final void Function(DateTimeSchedule) onSet;
  final DateTimeSchedule schedule;

  TaskScheduleSetterView(
      {Key? key, required this.onSet, required this.schedule})
      : super(key: key);

  final _dateEditingController = TextEditingController();
  final _timeEditingController = TextEditingController();

  selectTaskStartDate(context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month - 1);
    final lastDate = DateTime(now.year + 20);
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: schedule.start.date ?? now,
        firstDate: firstDate,
        lastDate: lastDate);
    if (newDate != null) {
      schedule.start.date = newDate;
      onSet(schedule);
    }
  }

  _selectTaskStartTime(context) async {
    final now = DateTime.now();
    final oneHourFromNow = now.add(const Duration(hours: 1));
    final initialTime =
        TimeOfDay(hour: oneHourFromNow.hour, minute: oneHourFromNow.minute);
    final TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime != null) {
      schedule.start.time = newTime;
      onSet(schedule);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final startDateText = schedule.start.date != null
        ? DateFormat.yMMMd().format(schedule.start.date!)
        : '';
    _dateEditingController.text = startDateText;
    final DateTime? startTimeDateTime = schedule.start.time != null
        ? schedule.start.time!.toDateTimeNow()
        : null;
    _timeEditingController.text = startTimeDateTime != null
        ? DateFormat.Hm().format(startTimeDateTime)
        : '';

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _dateEditingController,
              decoration: const InputDecoration(
                  labelText: 'Date', border: OutlineInputBorder()),
              onTap: () {
                selectTaskStartDate(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Set a due date';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeEditingController,
              decoration: const InputDecoration(
                  labelText: 'Time', border: OutlineInputBorder()),
              onTap: () {
                _selectTaskStartTime(context);
              },
            ),
          ],
        ));
  }
}
