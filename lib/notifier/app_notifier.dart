import 'dart:io';
import 'package:win_toast/win_toast.dart';

class AppNotifier {
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

  notify(AppNotification notification) {
    if (Platform.isWindows) {
      WinToast.instance()
          .showToast(type: ToastType.text01, title: notification.title);
    } else {}
  }
}

class AppNotification {
  final String title;
  final String message;

  AppNotification({required this.title, required this.message});
}
