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

  late Task _editedTask;
  final TextEditingController _titleController = TextEditingController();

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
    _editedTask = _appState.activeTask!;
    _descFocusNode = FocusNode();
    _appStateStorage = getIt<AppStateStorage>();
  }

  _updateTask() {
    _appState.updateActiveTask(_editedTask);
    _appStateStorage.save(_appState);
  }

  @override
  void didUpdateWidget(covariant TaskInfoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('did update');
    _editedTask = _appState.activeTask!;
  }

  @override
  Widget build(BuildContext context) {
    final addingNewSchedule =
        _activeTaskScheduleIndex == null && _showTaskSetterView;
    _titleController.text = _editedTask.title ?? '';

    final addNewReminder =
        _activeReminderIndex == null && _showReminderSetterView;

    return Consumer(
      builder: (context, value, child) {
        return SizedBox(
            width: 200,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Focus(
                      child: TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Set a title';
                          }
                          return null;
                        },
                      ),
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          _editedTask.title = _titleController.text;
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
      },
    );
  }
}
