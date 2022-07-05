import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:system_tray/system_tray.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/notifier/app_notifier.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:tasca/system_tray.dart';
import 'package:tasca/widgets/home_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  setup();
  final appStateStorage = getIt<AppStateStorage>();
  final appState = await appStateStorage.read();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => appState ?? AppState(),
    child: const MyApp(),
  ));
  await enableSystemTray();
}

void setup() {
  GetIt.I.registerSingleton<Notifier>(Notifier());
  getIt.registerSingleton<AppStateStorage>(AppStateStorage());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppState _appState;
  late Notifier _appNotifier;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of(context, listen: false);
    _appNotifier = getIt<Notifier>();
    _appNotifier.init();
    _appState.taskReminderDue.listen((task) {
      _appNotifier
          .notify(NotificationInfo(
              title: task.title!,
              message: task.getDueTime().toString(),
              actions: ['Snooze', 'Complete']))
          .then((notification) {
        notification.events.listen((event) {
          if (event is ActivatedEvent) {
            if (event.actionIndex == 0) {
              _appState.snoozeTaskReminder(task.id!);
            } else if (event.actionIndex == 1) {
              _appState.completeTask(task.id!);
            }
          }
        });
      });
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
