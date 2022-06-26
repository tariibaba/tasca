// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_repeat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRepeat _$TimeRepeatFromJson(Map<String, dynamic> json) => TimeRepeat()
  ..value = json['value'] as int?
  ..interval =
      $enumDecodeNullable(_$TimeRepeatIntervalEnumMap, json['interval']);

Map<String, dynamic> _$TimeRepeatToJson(TimeRepeat instance) =>
    <String, dynamic>{
      'value': instance.value,
      'interval': _$TimeRepeatIntervalEnumMap[instance.interval],
    };

const _$TimeRepeatIntervalEnumMap = {
  TimeRepeatInterval.minute: 'minute',
  TimeRepeatInterval.hour: 'hour',
};
