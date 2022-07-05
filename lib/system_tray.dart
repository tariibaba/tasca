import 'dart:io';

import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path/path.dart' as path;

Future<void> enableSystemTray() async {
  final enabler = SystemTrayInitializer();
  windowManager.addListener(enabler);
  await enabler.init();
}

class SystemTrayInitializer implements WindowListener {
  bool _isClosedFromTray = false;

  Future<void> init() async {
    await windowManager.setPreventClose(true);
    await initSystemTray();
  }

  @override
  void onWindowBlur() {}

  @override
  void onWindowClose() async {
    if (_isClosedFromTray) {
      await windowManager.destroy();
    } else {
      windowManager.hide();
    }
  }

  @override
  void onWindowEnterFullScreen() {}

  @override
  void onWindowEvent(String eventName) {}

  @override
  void onWindowFocus() {}

  @override
  void onWindowLeaveFullScreen() {}

  @override
  void onWindowMaximize() {}

  @override
  void onWindowMinimize() {}

  @override
  void onWindowMove() {}

  @override
  void onWindowMoved() {}

  @override
  void onWindowResize() {}

  @override
  void onWindowResized() {}

  @override
  void onWindowRestore() {}

  @override
  void onWindowUnmaximize() {}

  Future<void> initSystemTray() async {
    final menu = [
      MenuItem(label: 'Show', onClicked: () => windowManager.show()),
      MenuItem(label: 'Hide', onClicked: () => windowManager.hide()),
      MenuItem(
          label: 'Exit',
          onClicked: () {
            _isClosedFromTray = true;
            windowManager.close();
          }),
    ];

    final systemTray = SystemTray();
    final iconPath = Platform.isWindows
        ? './assets/images/flutter.ico'
        : './assets/images/flutter.png';
    await systemTray.initSystemTray(title: 'Tasca', iconPath: iconPath);
    await systemTray.setContextMenu(menu);
    systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == 'leftMouseDown') {
      } else if (eventName == 'leftMouseUp') {
        windowManager.show();
      } else if (eventName == 'rightMouseDown') {
      } else if (eventName == 'rightMouseUp') {
        systemTray.popUpContextMenu();
      }
    });
  }
}
