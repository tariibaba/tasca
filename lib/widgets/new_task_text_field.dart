import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/get_it.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/storage/app_state_storage.dart';
import 'package:uuid/uuid.dart';

class NewTaskTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTaskTextFieldState();
  }
}

class _NewTaskTextFieldState extends State<NewTaskTextField> {
  final _formKey = GlobalKey();

  Task? _newTask;
  late AppState _appState;
  late FocusNode _descFocusNode;
  late AppStateStorage _localStorage;

  final _descController = TextEditingController();

  _createTask() {
    _newTask = Task()
      ..description = _descController.text
      ..id = Uuid().v4();
    _appState.createTask(_newTask!);
    _localStorage
        .save(_appState)
        .then((value) => print('saved app state successfully'));
    _descController.text = '';
    _descFocusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _descController.addListener(() {
      setState(() {});
    });
    _descFocusNode = FocusNode();
    _localStorage = getIt<AppStateStorage>();
  }

  @override
  Widget build(BuildContext context) {
    final showAddButton = !_descController.text.isEmpty;
    return Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: showAddButton
                  ? IconButton(
                      onPressed: () {
                        _createTask();
                      },
                      icon: Icon(Icons.add))
                  : null,
              errorBorder: null,
              errorStyle: TextStyle(height: 0)),
          onFieldSubmitted: (text) {
            _createTask();
          },
          controller: _descController,
          focusNode: _descFocusNode,
        ));
  }
}
