// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task()
  ..id = json['id'] as String?
  ..description = json['description'] as String?
  ..schedules = (json['schedules'] as List<dynamic>)
      .map((e) => DateTimeSchedule.fromJson(e as Map<String, dynamic>))
      .toList()
  ..reminders = (json['reminders'] as List<dynamic>)
      .map((e) => TaskReminder.fromJson(e as Map<String, dynamic>))
      .toList()
  ..isComplete = json['isComplete'] as bool
  ..lastRemindTime = json['lastRemindTime'] == null
      ? null
      : DateTime.parse(json['lastRemindTime'] as String);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'schedules': instance.schedules,
      'reminders': instance.reminders,
      'isComplete': instance.isComplete,
      'lastRemindTime': instance.lastRemindTime?.toIso8601String(),
    };
