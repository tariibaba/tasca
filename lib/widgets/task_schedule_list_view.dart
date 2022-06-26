import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/widgets/task_schedule_setter_view.dart';

class TaskScheduleListView extends StatefulWidget {
  const TaskScheduleListView({Key? key}) : super(key: key);

  @override
  State<TaskScheduleListView> createState() => _TaskScheduleListViewState();
}

class _TaskScheduleListViewState extends State<TaskScheduleListView> {
  int? _activeScheduleIndex;

  bool _showScheduleSetterView = false;
  late Task _task;

  _handleSetTaskSchedule(DateTimeSchedule schedule) {
    if (_activeScheduleIndex == null) {
      _task.schedules.add(schedule);
    } else {
      _task.schedules[_activeScheduleIndex!] = schedule;
    }
    _appState.update();
  }

  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _task = _appState.activeTask!;
  }

  @override
  Widget build(BuildContext context) {
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
                              _appState.update();
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
                ..start = (TaskDateTime()..date = DateTime.now()));
              _activeScheduleIndex = _task.schedules.length - 1;
              _appState.update();
            });
          },
          child: Row(
            children: const [Icon(Icons.add), Text('Add schedule')],
          ),
        ),
      ],
    );
  }
}
