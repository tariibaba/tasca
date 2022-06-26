import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:tasca/models/app_state.dart';

class AppStateStorage {
  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _getLocalFile() async {
    final path = await _getLocalPath();
    return File('$path/data.json');
  }

  Future<AppState?> read() async {
    try {
      final file = await _getLocalFile();
      final contents = await file.readAsString();
      return AppState.fromJson(jsonDecode(contents));
    } catch (e) {
      return null;
    }
  }

  Future<void> save(AppState state) async {
    final file = await _getLocalFile();
    await file.writeAsString(const JsonEncoder.withIndent(' ').convert(state));
  }
}
