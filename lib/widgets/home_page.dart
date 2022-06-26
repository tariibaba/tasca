import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/app_state.dart';
import 'package:tasca/widgets/declarative_route_pusher.dart';
import 'package:tasca/widgets/new_task_text_field.dart';
import 'package:tasca/widgets/task_info_screen.dart';
import 'package:tasca/widgets/task_info_view.dart';
import 'package:tasca/widgets/task_list_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(
                  child: ReminderListView(),
                ),
                NewTaskTextField()
              ],
            )),
            Consumer<AppState>(
              builder: (context, state, child) {
                if (width >= 600 && state.isTaskInfoViewOpen) {
                  return SizedBox(width: 300, child: TaskInfoView());
                } else {
                  return Container();
                }
              },
            )
          ],
        )),
        Consumer<AppState>(
          builder: (context, value, child) => DeclarativeRoutePusher(
              open: value.isTaskInfoViewOpen && width < 600,
              context: context,
              routeCreator: () => MaterialPageRoute<Object>(
                    builder: (context) => TaskInfoScreen(),
                  )),
        )
      ],
    ));
  }
}
