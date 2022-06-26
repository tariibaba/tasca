import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';

part 'task_repeat.g.dart';

@JsonSerializable()
class TaskRepeat {
  DayRepeat? day;
  TimeRepeat? time;
  TaskRepeatFrom from = TaskRepeatFrom.dueTime;

  TaskRepeat clone() {
    return TaskRepeat()
      ..day = day?.clone()
      ..time = time?.clone()
      ..from = from;
  }

  TaskRepeat();

  factory TaskRepeat.fromJson(Map<String, dynamic> json) =>
      _$TaskRepeatFromJson(json);
  Map<String, dynamic> toJson() => _$TaskRepeatToJson(this);
}
