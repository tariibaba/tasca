import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:tasca/utils/index.dart';
import 'package:tasca/widgets/task_info_view.dart';

class ReminderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStateStorage = getIt<AppStateStorage>();
    final disabledColor = Theme.of(context).disabledColor;
    return Consumer<AppState>(builder: (context, state, child) {
      return ListView.builder(
          itemCount: state.taskList.length,
          itemBuilder: ((context, index) {
            final task = state.taskList[index];
            final taskId = task.id!;
            return GestureDetector(
                onTap: () {
                  state.toggleTaskInfoView(taskId);
                },
                child: Card(
                    color: task.isComplete
                        ? ColorExtensions.hexWithOpacity('ffffff', 0.5)
                        : null,
                    elevation: task.isComplete ? 0 : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                            value: task.isComplete,
                            onChanged: (value) {
                              state.setTaskCompletion(task.id!, value!);
                            }),
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(task.title!,
                                  style: (TextStyle(
                                      color: task.isComplete
                                          ? Theme.of(context).disabledColor
                                          : null)))),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(task.getDueTime()?.toString() ?? '',
                                  style: TextStyle(
                                      color: task.isComplete
                                          ? Theme.of(context).disabledColor
                                          : null))),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  state.showTaskInfoView(task.id!);
                                },
                                icon: Icon(Icons.info),
                                color: task.isComplete ? disabledColor : null),
                            IconButton(
                                onPressed: () {
                                  state.deleteTask(task.id!);
                                  appStateStorage.save(state);
                                },
                                icon: Icon(Icons.delete),
                                color: task.isComplete ? disabledColor : null),
                          ],
                        )
                      ],
                    )));
          }));
    });
  }
}
