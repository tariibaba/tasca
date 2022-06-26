import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasca/models/index.dart';
import 'package:tasca/widgets/task_info_screen.dart';

class DeclarativeRoutePusher extends StatefulWidget {
  bool open;
  final BuildContext context;
  final Route<Object> Function() routeCreator;

  DeclarativeRoutePusher(
      {Key? key,
      required this.open,
      required this.context,
      required this.routeCreator})
      : super(key: key);

  @override
  State<DeclarativeRoutePusher> createState() => _DeclarativeRoutePusherState();
}

class _DeclarativeRoutePusherState extends State<DeclarativeRoutePusher> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DeclarativeRoutePusher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.open != widget.open) {
      if (widget.open) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          pushRoute();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
        });
      }
    }
  }

  void pushRoute() {
    Navigator.push(context, widget.routeCreator());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
