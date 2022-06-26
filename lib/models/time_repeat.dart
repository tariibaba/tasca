import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';

part 'time_repeat.g.dart';

@JsonSerializable()
class TimeRepeat {
  int? value;
  TimeRepeatInterval? interval;

  TimeRepeat clone() {
    return TimeRepeat();
  }

  TimeRepeat();

  factory TimeRepeat.fromJson(Map<String, dynamic> json) =>
      _$TimeRepeatFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRepeatToJson(this);
}
