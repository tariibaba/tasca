import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:tasca/widgets/task_schedule_setter_view.dart';

class TaskScheduleListView extends StatefulWidget {
  const TaskScheduleListView({Key? key}) : super(key: key);

  @override
  State<TaskScheduleListView> createState() => _TaskScheduleListViewState();
}

class _TaskScheduleListViewState extends State<TaskScheduleListView> {
  int? _activeScheduleIndex;
  late Task _task;
  bool _showScheduleSetterView = false;

  _handleSetTaskSchedule(DateTimeSchedule schedule) {
    if (_activeScheduleIndex == null) {
      _task.schedules.add(schedule);
    } else {
      _task.schedules[_activeScheduleIndex!] = schedule;
    }
    _appState.updateActiveTask(_task);
    _appStateStorage.save(_appState);
  }

  late AppState _appState;
  late AppStateStorage _appStateStorage;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _task = _appState.activeTask!;
    _appStateStorage = getIt<AppStateStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) {
      return Column(
        children: [
          const Text('Schedules'),
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final schedule = _task.schedules[index];
                return _activeScheduleIndex == index && _showScheduleSetterView
                    ? Column(children: [
                        TaskScheduleSetterView(
                            schedule: schedule.clone(),
                            onSet: (schedule) {
                              _handleSetTaskSchedule(schedule);
                            }),
                        ButtonBar(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _showScheduleSetterView = false;
                                    _activeScheduleIndex = null;
                                  });
                                },
                                child: const Text('Done')),
                          ],
                        )
                      ])
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(label: Text(schedule.getRangeString())),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _activeScheduleIndex = index;
                                  _showScheduleSetterView = true;
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _task.schedules.removeAt(index);
                                  if (_showScheduleSetterView &&
                                      index < _activeScheduleIndex!) {
                                    _activeScheduleIndex =
                                        _activeScheduleIndex! - 1;
                                  }
                                });
                                _appState.updateActiveTask(_task);
                                _appStateStorage.save(_appState);
                              },
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ));
              },
              itemCount: _task.schedules.length),
          TextButton(
            onPressed: () {
              setState(() {
                _showScheduleSetterView = true;
                _task.schedules.add(DateTimeSchedule()
                  ..start = (TaskDateTime()..date = clock.now()));
                _activeScheduleIndex = _task.schedules.length - 1;
                _appState.updateActiveTask(_task);
                _appStateStorage.save(_appState);
              });
            },
            child: Row(
              children: const [Icon(Icons.add), Text('Add schedule')],
            ),
          ),
        ],
      );
    });
  }
}
