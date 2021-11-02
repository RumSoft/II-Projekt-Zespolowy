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
  VerticalTabs vtabs = VerticalTabs(
    tabsWidth: 120,
    direction: TextDirection.ltr,
    contentScrollAxis: Axis.vertical,
    changePageDuration: Duration(milliseconds: 500),
    tabData: <TabData>[],
  );

  _MainPageState() {
    GetUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              list.add(TabData(Tab(child: Text(item.Name)),
                  UserContent(key: gk, caption: item.Name), item.Id, gk));
            }
            vtabs.tabData = list;
          })
        });
    return list;
  }
}

class UserContent extends StatefulWidget {
  UserContent({Key? key, required this.caption, this.description = ''})
      : super(key: key);

  String caption;
  String description;

  @override
  State<UserContent> createState() => UserContentState();
}

class UserContentState extends State<UserContent> {
  final ScrollController? scrrollController = ScrollController();

  methodInChild(String desc) => setState(() {
        widget.description = desc;
      });

  refresh(String desc) {
    setState(() {
      widget.description = desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Text(
            widget.caption,
            style: TextStyle(fontSize: 20),
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
                          child: Expanded(
                            flex: 1,
                            child: RawScrollbar(
                              thumbColor: Colors.orangeAccent,
                              radius: Radius.circular(20),
                              thickness: 5,
                              child: SingleChildScrollView(
                                reverse: false,
                                child: Text(widget.description,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.white)),
                              ),
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
                        child: Text('',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white)),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
