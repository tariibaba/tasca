import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/models/app_state.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:tasca/widgets/task_reminder_setter_view.dart';
import 'package:dart_date/dart_date.dart';

class TaskReminderListView extends StatefulWidget {
  const TaskReminderListView({Key? key}) : super(key: key);

  @override
  State<TaskReminderListView> createState() => _TaskReminderListViewState();
}

class _TaskReminderListViewState extends State<TaskReminderListView> {
  int? _activeReminderIndex = null;
  late AppState _appState;
  late AppStateStorage _appStateStorage;
  bool _showReminderSetterView = false;
  late Task _task;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of(context, listen: false);
    _task = _appState.activeTask!;
    _appStateStorage = getIt<AppStateStorage>();
  }

  @override
  Widget build(BuildContext context) {
    final nextRemindTime = _task.getNextRemindTime();
    return Consumer(
      builder: (context, value, child) {
        return Column(
          children: [
            Text('Reminders'),
            if (nextRemindTime != null)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.notifications),
                Text(nextRemindTime.format('MMM dd, yyyy h:mm a')),
              ]),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _task.reminders.length,
              itemBuilder: (context, index) {
                final reminder = _task.reminders[index];
                return _activeReminderIndex == index && _showReminderSetterView
                    ? Column(
                        children: [
                          TaskReminderSetterView(
                              reminder: reminder,
                              onSet: (reminder) {
                                _task.reminders[index] = reminder;
                                _appState.updateActiveTask(_task);
                                _appStateStorage.save(_appState);
                              }),
                          ButtonBar(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showReminderSetterView = false;
                                      _activeReminderIndex = null;
                                    });
                                  },
                                  child: const Text('Done')),
                            ],
                          )
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(children: [
                          Chip(label: Text(reminder.toString())),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _activeReminderIndex = index;
                                _showReminderSetterView = true;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _task.reminders.removeAt(index);
                                if (_showReminderSetterView &&
                                    index < _activeReminderIndex!) {
                                  _activeReminderIndex =
                                      _activeReminderIndex! - 1;
                                }
                              });
                              _appState.updateActiveTask(_task);
                            },
                            icon: const Icon(Icons.close),
                          )
                        ]),
                      );
              },
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showReminderSetterView = true;
                  _task.reminders.add(TaskReminder.whenDue);
                  _activeReminderIndex = _task.reminders.length - 1;
                  _appState.updateActiveTask(_task);
                  _appStateStorage.save(_appState);
                });
              },
              child: Row(
                children: const [Icon(Icons.add), Text('Add reminder')],
              ),
            ),
          ],
        );
      },
    );
  }
}
