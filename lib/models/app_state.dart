import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/storage/app_state_storage.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState extends ChangeNotifier {
  List<String> taskIds = [];
  Map<String, Task> allTasks = {};
  @JsonKey(ignore: true)
  String? activeTaskId;
  @JsonKey(ignore: true)
  bool isTaskInfoViewOpen = false;

  List<Task> get taskList {
    return taskIds.map((id) => allTasks[id]!).toList();
  }

  void createTask(Task newTask) {
    final id = newTask.id;
    taskIds.add(id!);
    allTasks[id] = newTask;
    notifyListeners();
  }

  void updateActiveTask(Task updatedTask) {
    allTasks[activeTaskId!] = updatedTask;
    notifyListeners();
  }

  void setTaskCompletion(String taskId, bool completed) {
    final task = allTasks[taskId]!;
    task.isComplete = completed;
    notifyListeners();
  }

  void showTaskInfoView(String taskId) {
    activeTaskId = taskId;
    isTaskInfoViewOpen = true;
    notifyListeners();
  }

  void closeTaskInfoView() {
    activeTaskId = null;
    isTaskInfoViewOpen = false;
    notifyListeners();
  }

  Task? get activeTask {
    return allTasks[activeTaskId];
  }

  void update() {
    notifyListeners();
  }

  void startTaskReminderDueCheck() {
    const devInterval = 10;
    const interval = kDebugMode ? devInterval : 60;
    final timer = Timer.periodic(Duration(seconds: devInterval), (timer) {
      print('Checking for reminder notification');
      taskList.where((task) => !task.isComplete).forEach((task) {
        print('isReminderDue: ${task.isReminderDue()}');
        if (task.isReminderDue()) {
          print('Reminder due');
          taskReminderDueController.add(task);
        }
      });
    });
  }

  @JsonKey(ignore: true)
  StreamController<Task> taskReminderDueController =
      StreamController.broadcast();
  Stream<Task> get taskReminderDue => taskReminderDueController.stream;

  AppState();

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
