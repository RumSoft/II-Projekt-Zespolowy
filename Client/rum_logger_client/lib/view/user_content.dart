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
    var userName = Row(
      children: [
        OnlineWidget(widget.Id),
        Text(
          widget.caption,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );

    var divider = const Divider(
      height: 15,
      color: Colors.black45,
    );

    var verticalDivider = const VerticalDivider(
      width: 15,
      color: Colors.black45,
    );

    var rawData = Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text("Raw data:")),
        Expanded(
          child: Material(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RawScrollbar(
                  thumbColor: Colors.orangeAccent,
                  radius: const Radius.circular(20),
                  thickness: 5,
                  child: SingleChildScrollView(
                    reverse: false,
                    child: SelectableText(widget.description.Log,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              )),
        ),
      ],
    ));

    var filteredData = Column(
      children: [
        const Text("Filtered data:"),
        Expanded(
          child: SizedBox(
              width: 800,
              child: Material(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RawScrollbar(
                      thumbColor: Colors.orangeAccent,
                      radius: const Radius.circular(20),
                      thickness: 5,
                      child: SingleChildScrollView(
                        reverse: false,
                        child: SelectableText(widget.description.FilteredLogs,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ))),
        ),
      ],
    );

    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          userName,
          divider,
          Expanded(
            child: Row(
              children: [rawData, verticalDivider, filteredData],
            ),
          ),
        ],
      ),
    );
  }
}
