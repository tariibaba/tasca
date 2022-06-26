// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskReminder _$TaskReminderFromJson(Map<String, dynamic> json) => TaskReminder()
  ..type = $enumDecode(_$TaskReminderTypeEnumMap, json['type'])
  ..timeBeforeDue = json['timeBeforeDue'] == null
      ? null
      : TaskReminderTimeBeforeDue.fromJson(
          json['timeBeforeDue'] as Map<String, dynamic>)
  ..customSchedule = json['customSchedule'] == null
      ? null
      : DateTimeSchedule.fromJson(
          json['customSchedule'] as Map<String, dynamic>);

Map<String, dynamic> _$TaskReminderToJson(TaskReminder instance) =>
    <String, dynamic>{
      'type': _$TaskReminderTypeEnumMap[instance.type],
      'timeBeforeDue': instance.timeBeforeDue,
      'customSchedule': instance.customSchedule,
    };

const _$TaskReminderTypeEnumMap = {
  TaskReminderType.whenDue: 'whenDue',
  TaskReminderType.beforeDue: 'beforeDue',
  TaskReminderType.custom: 'custom',
};
