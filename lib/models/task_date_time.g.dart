// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_date_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDateTime _$TaskDateTimeFromJson(Map<String, dynamic> json) => TaskDateTime()
  ..date = json['date'] == null ? null : DateTime.parse(json['date'] as String)
  ..time = const TimeOfDayJsonConverter().fromJson(json['time'] as String?);

Map<String, dynamic> _$TaskDateTimeToJson(TaskDateTime instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'time': const TimeOfDayJsonConverter().toJson(instance.time),
    };
