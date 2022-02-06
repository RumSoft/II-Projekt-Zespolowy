import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rum_logger_client/service/user_service.dart';

class OnlineWidget extends StatefulWidget {
  final int Id;

  const OnlineWidget(
    this.Id, {
    Key? key,
  }) : super(key: key);

  @override
  State<OnlineWidget> createState() => _OnlineWidgetState();
}

class _OnlineWidgetState extends State<OnlineWidget> {
  UserService userService = UserService();
  Color iconColor = Colors.green;

  _OnlineWidgetState() {
    const oneSec = Duration(seconds: 10);

    Timer.periodic(
        oneSec,
        (Timer t) =>
            userService.IsUserOnline(widget.Id, iconColor == Colors.green)
                .then((value) => {
                      setState(() {
                        iconColor = value ? Colors.green : Colors.red;
                      })
                    }));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Icon(
        Icons.circle,
        size: 10,
        color: iconColor,
      ),
    );
  }
}
