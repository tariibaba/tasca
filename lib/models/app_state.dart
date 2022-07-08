import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasca/models/index.dart';

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

  void hideTaskInfoView() {
    activeTaskId = null;
    isTaskInfoViewOpen = false;
    notifyListeners();
  }

  Task? get activeTask {
    return allTasks[activeTaskId];
  }

  void startTaskReminderDueCheck() {
    const devInterval = 10;
    const interval = kDebugMode ? devInterval : 60;
    Timer.periodic(const Duration(seconds: interval), (timer) {
      taskList.where((task) => !task.isComplete).forEach((task) {
        if (task.isReminderDue()) {
          task.hasReminded();
          taskReminderDueController.add(task);
        }
      });
    });
  }

  void snoozeTaskReminder(String taskId) {
    final task = allTasks[taskId];
    task!.snooze();
    notifyListeners();
  }

  void completeTask(String taskId) {
    final task = allTasks[taskId]!;
    task.isComplete = true;
    notifyListeners();
  }

  void deleteTask(String taskId) {
    taskIds.remove(taskId);
    allTasks.remove(taskId);
    if (activeTaskId == taskId) {
      hideTaskInfoView();
    }
    notifyListeners();
  }

  void toggleTaskInfoView(String taskId) {
    if (activeTaskId == taskId) {
      hideTaskInfoView();
    } else {
      showTaskInfoView(taskId);
    }
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
