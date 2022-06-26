// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_reminder_time_before_due.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskReminderTimeBeforeDue _$TaskReminderTimeBeforeDueFromJson(
        Map<String, dynamic> json) =>
    TaskReminderTimeBeforeDue(
      json['value'] as int,
      $enumDecode(_$TaskReminderTimeBeforeDueUnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$TaskReminderTimeBeforeDueToJson(
        TaskReminderTimeBeforeDue instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': _$TaskReminderTimeBeforeDueUnitEnumMap[instance.unit],
    };

const _$TaskReminderTimeBeforeDueUnitEnumMap = {
  TaskReminderTimeBeforeDueUnit.minute: 'minute',
  TaskReminderTimeBeforeDueUnit.hour: 'hour',
  TaskReminderTimeBeforeDueUnit.day: 'day',
  TaskReminderTimeBeforeDueUnit.week: 'week',
  TaskReminderTimeBeforeDueUnit.month: 'month',
  TaskReminderTimeBeforeDueUnit.year: 'year',
};
