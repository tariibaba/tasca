import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/widgets/task_info_view.dart';

class TaskInfoScreen extends StatefulWidget {
  @override
  State<TaskInfoScreen> createState() => _TaskInfoScreenState();
}

class _TaskInfoScreenState extends State<TaskInfoScreen> {
  late AppState _appState;
  bool _taskInfoViewOpen = true;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _appState.addListener(() {
      // if (_appState.isTaskInfoViewOpen == false) {
      //   if (!_appState.isTaskInfoViewOpen ||
      //       MediaQuery.of(context).size.width > 600) {
      //     Navigator.pop(context);
      //   }
      // }
    });
  }

  @override
  void didUpdateWidget(covariant TaskInfoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TaskInfoView());
  }
}
