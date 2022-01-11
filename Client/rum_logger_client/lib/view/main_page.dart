import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rum_logger_client/service/user_service.dart';

import 'vertical_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pkey = GlobalKey<UserContentState>();
  VerticalTabs vtabs = VerticalTabs(
    tabsWidth: 120,
    direction: TextDirection.ltr,
    contentScrollAxis: Axis.vertical,
    changePageDuration: Duration(milliseconds: 500),
    tabData: <TabData>[
      //   TabData(
      //       Tab(
      //           child: Row(
      //         children: [
      //           OnlineWidget(0),
      //           Text("no users"),
      //         ],
      //       )),
      //       UserContent(
      //         key: GlobalKey<UserContentState>(),
      //         caption: "no users",
      //         Id: 0,
      //       ),
      //       0,
      //       GlobalKey<UserContentState>())
    ],
  );
  bool loading = true;
  _MainPageState() {
    GetUserList();
  }
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: SafeArea(child: Container(width: 1200, child: vtabs)),
          );
  }

  List<TabData> GetUserList() {
    var userService = UserService();
    List<TabData> list = <TabData>[];

    var users = userService.GetUserList().then((value) => {
          setState(() {
            var list = <TabData>[];
            for (var item in value) {
              var gk = GlobalKey<UserContentState>();
              list.add(TabData(
                  Tab(
                      child: Row(
                    children: [
                      OnlineWidget(item.Id),
                      Text(item.Name),
                    ],
                  )),
                  UserContent(
                    key: gk,
                    caption: item.Name,
                    Id: item.Id,
                  ),
                  item.Id,
                  gk));
            }
            vtabs.tabData = list;
            loading = false;
          })
        });
    return list;
  }
}

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

class UserLogs {
  String Log = "";
  String FilteredLogs = "";
  UserLogs(this.Log, this.FilteredLogs);
}

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
                    width: 400,
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
