import 'package:flutter/material.dart';
import 'package:rum_logger_client/model/user_logs.dart';

import 'online_icon.dart';

class UserContent extends StatefulWidget {
  UserContent({Key? key, required this.caption, required this.Id})
      : super(key: key);

  String caption;
  UserLogs description = UserLogs("", "");
  int Id;
  bool loading = true;

  @override
  State<UserContent> createState() => UserContentState();
}

class UserContentState extends State<UserContent> {
  final ScrollController? scrrollController = ScrollController();

  methodInChild(UserLogs desc) => setState(() {
        widget.description.Log = desc.Log;
        widget.description.FilteredLogs = desc.FilteredLogs;
      });

  refresh(UserLogs desc) {
    setState(() {
      widget.description.Log = desc.Log;
      widget.description.FilteredLogs = desc.FilteredLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              OnlineWidget(widget.Id),
              Text(
                widget.caption,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Divider(
            height: 15,
            color: Colors.black45,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Material(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: RawScrollbar(
                            thumbColor: Colors.orangeAccent,
                            radius: Radius.circular(20),
                            thickness: 5,
                            child: SingleChildScrollView(
                              reverse: false,
                              child: SelectableText(widget.description.Log,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ))),
                VerticalDivider(
                  width: 15,
                  color: Colors.black45,
                ),
                Container(
                    width: 800,
                    child: Material(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: RawScrollbar(
                            thumbColor: Colors.orangeAccent,
                            radius: Radius.circular(20),
                            thickness: 5,
                            child: SingleChildScrollView(
                              reverse: false,
                              child: SelectableText(
                                  widget.description.FilteredLogs,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
