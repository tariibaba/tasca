import 'dart:async';
import 'dart:io';
import 'package:win_toast/win_toast.dart' show WinToast, ToastType;
import 'package:win_toast/win_toast.dart' as wt;

class Notifier {
  late final Future<void> _winToastInit;
  bool _winToastInitComplete = false;
  Future<void> init() async {
    _winToastInit = _initWinToast();
    await _winToastInit;
  }

  Future<void> _initWinToast() async {
    WinToast.instance().initialize(
        appName: 'com.tariibaba.tasca',
        productName: 'Tasca',
        companyName: 'Ayibatari Ibaba');
    _winToastInitComplete = true;
  }

  Future<WinToast?> _getWinToastInstance() async {
    if (!_winToastInitComplete) {
      await _winToastInit;
    }
    return WinToast.instance();
  }

  Future<Notification> notify(NotificationInfo notification) async {
    Completer<Notification> completer = Completer();
    if (Platform.isWindows) {
      (await _getWinToastInstance())
          ?.showToast(
              type: ToastType.text02,
              title: notification.title,
              subtitle: notification.message,
              actions: notification.actions)
          .then((value) {
        final notification = Notification();
        value!.eventStream.listen((event) {
          if (event is wt.DissmissedEvent) {
            notification._eventsController.add(DismissedEvent());
          } else if (event is wt.ActivatedEvent) {
            notification._eventsController
                .add(ActivatedEvent(actionIndex: event.actionIndex));
          }
        });
        completer.complete(notification);
      });
    } else {}
    return completer.future;
  }
}

class NotificationInfo {
  final String title;
  final String message;
  List<String> actions = [];

  NotificationInfo(
      {required this.title, required this.message, this.actions = const []});
}

class Notification {
  final StreamController<NotificationEvent> _eventsController =
      StreamController.broadcast();

  Stream<NotificationEvent> get events {
    return _eventsController.stream;
  }
}

class NotificationEvent {}

class DismissedEvent extends NotificationEvent {}

class ActivatedEvent extends NotificationEvent {
  int? actionIndex;

  ActivatedEvent({this.actionIndex});
}

class AppNotificationAction {
  final String action;

  AppNotificationAction({required this.action});
}
