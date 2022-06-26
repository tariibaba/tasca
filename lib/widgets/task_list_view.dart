import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/widgets/task_info_view.dart';

class ReminderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return ListView.builder(
          itemCount: state.taskList.length,
          itemBuilder: ((context, index) {
            final task = state.taskList[index];
            return Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    value: task.isComplete,
                    onChanged: (value) {
                      state.setTaskCompletion(task.id!, value!);
                    }),
                Text(task.description!),
                Text(task.getDueTime()?.toString() ?? ''),
                IconButton(
                    onPressed: () {
                      state.showTaskInfoView(task.id!);
                    },
                    icon: Icon(Icons.edit))
              ],
            ));
          }));
    });
  }
}
