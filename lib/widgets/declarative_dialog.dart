import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/index.dart';

class DeclarativeDialog extends StatefulWidget {
  bool open;
  final BuildContext context;
  final Widget Function() creator;

  DeclarativeDialog(
      {Key? key,
      required this.open,
      required this.context,
      required this.creator})
      : super(key: key);

  @override
  State<DeclarativeDialog> createState() => _DeclarativeDialogState();
}

class _DeclarativeDialogState extends State<DeclarativeDialog> {
  @override
  void initState() {
    super.initState();
    if (widget.open) {
      openDialog();
    }
  }

  @override
  void didUpdateWidget(covariant DeclarativeDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.open != widget.open) {
      if (widget.open) {
        openDialog();
      }
    }
  }

  void openDialog() {
    showDialog(context: context, builder: (context) => widget.creator())
        .then((value) {
      widget.open = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
