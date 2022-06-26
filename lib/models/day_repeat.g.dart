// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_repeat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayRepeat _$DayRepeatFromJson(Map<String, dynamic> json) => DayRepeat()
  ..value = json['value'] as int?
  ..interval = $enumDecodeNullable(_$DayRepeatIntervalEnumMap, json['interval'])
  ..daysOfWeek = (json['daysOfWeek'] as List<dynamic>)
      .map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
      .toList();

Map<String, dynamic> _$DayRepeatToJson(DayRepeat instance) => <String, dynamic>{
      'value': instance.value,
      'interval': _$DayRepeatIntervalEnumMap[instance.interval],
      'daysOfWeek':
          instance.daysOfWeek.map((e) => _$DayOfWeekEnumMap[e]).toList(),
    };

const _$DayRepeatIntervalEnumMap = {
  DayRepeatInterval.day: 'day',
  DayRepeatInterval.week: 'week',
  DayRepeatInterval.month: 'month',
  DayRepeatInterval.year: 'year',
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'monday',
  DayOfWeek.tuesday: 'tuesday',
  DayOfWeek.wednesday: 'wednesday',
  DayOfWeek.thursday: 'thursday',
  DayOfWeek.friday: 'friday',
  DayOfWeek.saturday: 'saturday',
  DayOfWeek.sunday: 'sunday',
};
