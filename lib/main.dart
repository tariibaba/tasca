import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/notifier/app_notifier.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:tasca/widgets/home_page.dart';

void main() async {
  setup();
  final localStorage = getIt<AppStateStorage>();
  final appState = await localStorage.read();
  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

void setup() {
  GetIt.I.registerSingleton<AppNotifier>(AppNotifier());
  getIt.registerSingleton<AppStateStorage>(AppStateStorage());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppState _appState;
  late AppNotifier _appNotifier;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of(context, listen: false);
    _appNotifier = getIt<AppNotifier>();
    _appState.taskReminderDue.listen((task) {
      _appNotifier
          .notify(AppNotification(title: task.description!, message: ''));
    });
    _appState.startTaskReminderDueCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
