// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeSchedule _$DateTimeScheduleFromJson(Map<String, dynamic> json) =>
    DateTimeSchedule()
      ..start = TaskDateTime.fromJson(json['start'] as Map<String, dynamic>)
      ..repeat = TaskRepeat.fromJson(json['repeat'] as Map<String, dynamic>)
      ..end = TaskDateTime.fromJson(json['end'] as Map<String, dynamic>);

Map<String, dynamic> _$DateTimeScheduleToJson(DateTimeSchedule instance) =>
    <String, dynamic>{
      'start': instance.start,
      'repeat': instance.repeat,
      'end': instance.end,
    };
