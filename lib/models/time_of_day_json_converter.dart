import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayJsonConverter extends JsonConverter<TimeOfDay?, String> {
  const TimeOfDayJsonConverter();

  @override
  TimeOfDay? fromJson(String json) {
    final arr = json.split(':');
    return TimeOfDay(hour: int.parse(arr[0]), minute: int.parse(arr[1]));
  }

  @override
  String toJson(TimeOfDay? object) {
    return '${object!.hour}:${object.minute}';
  }
}
