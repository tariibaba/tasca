// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState()
  ..taskIds =
      (json['taskIds'] as List<dynamic>).map((e) => e as String).toList()
  ..allTasks = (json['allTasks'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Task.fromJson(e as Map<String, dynamic>)),
  );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'taskIds': instance.taskIds,
      'allTasks': instance.allTasks,
    };
