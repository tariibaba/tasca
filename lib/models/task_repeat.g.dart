// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_repeat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskRepeat _$TaskRepeatFromJson(Map<String, dynamic> json) => TaskRepeat()
  ..day = json['day'] == null
      ? null
      : DayRepeat.fromJson(json['day'] as Map<String, dynamic>)
  ..time = json['time'] == null
      ? null
      : TimeRepeat.fromJson(json['time'] as Map<String, dynamic>)
  ..from = $enumDecode(_$TaskRepeatFromEnumMap, json['from']);

Map<String, dynamic> _$TaskRepeatToJson(TaskRepeat instance) =>
    <String, dynamic>{
      'day': instance.day,
      'time': instance.time,
      'from': _$TaskRepeatFromEnumMap[instance.from],
    };

const _$TaskRepeatFromEnumMap = {
  TaskRepeatFrom.dueTime: 'dueTime',
  TaskRepeatFrom.completionTime: 'completionTime',
};
