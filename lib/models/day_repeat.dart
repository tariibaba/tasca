import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';

part 'day_repeat.g.dart';

@JsonSerializable()
class DayRepeat {
  int? value;
  DayRepeatInterval? interval;
  List<DayOfWeek> daysOfWeek = [];

  DayRepeat clone() {
    return DayRepeat();
  }

  DayRepeat();
  factory DayRepeat.fromJson(Map<String, dynamic> json) =>
      _$DayRepeatFromJson(json);
  Map<String, dynamic> toJson() => _$DayRepeatToJson(this);
}
