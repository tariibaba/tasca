import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/main.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:tasca/widgets/task_schedule_list_view.dart';
import 'package:tasca/widgets/task_reminder_list_view.dart';
import 'package:tasca/widgets/task_reminder_setter_view.dart';
import 'package:tasca/widgets/task_schedule_setter_view.dart';
import 'package:uuid/uuid.dart';

class TaskInfoView extends StatefulWidget {
  TaskInfoView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskInfoViewState();
  }
}

class _TaskInfoViewState extends State<TaskInfoView> {
  final _formKey = GlobalKey<FormState>();

  late Task _task;
  final TextEditingController _descController = TextEditingController();

  bool _showTaskSetterView = false;
  int? _activeTaskScheduleIndex;

  bool _showReminderSetterView = false;
  int? _activeReminderIndex;

  late FocusNode _descFocusNode;

  late AppState _appState;
  late AppStateStorage _appStateStorage;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _task = _appState.allTasks[_appState.activeTaskId]!;
    _descFocusNode = FocusNode();
    _appStateStorage = getIt<AppStateStorage>();
  }

  _updateTask() {
    _appState.updateActiveTask(_task);
    _appStateStorage.save(_appState);
  }

  @override
  Widget build(BuildContext context) {
    final addingNewSchedule =
        _activeTaskScheduleIndex == null && _showTaskSetterView;
    _descController.text = _task.description ?? '';

    final addNewReminder =
        _activeReminderIndex == null && _showReminderSetterView;

    return SizedBox(
        width: 200,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Focus(
                  child: TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Set a description';
                      }
                      return null;
                    },
                  ),
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      _task.description = _descController.text;
                      _updateTask();
                    }
                  },
                ),
                TaskScheduleListView(),
                TaskReminderListView(),
                ButtonBar(
                  children: [
                    TextButton(
                        onPressed: () {
                          _appState.closeTaskInfoView();
                        },
                        child: const Text('Close')),
                  ],
                )
              ],
            )));
  }
}
