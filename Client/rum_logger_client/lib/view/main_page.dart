import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rum_logger_client/model/user_logs.dart';
import 'package:rum_logger_client/service/user_service.dart';
import 'package:rum_logger_client/view/user_content.dart';

import 'online_icon.dart';
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
    tabsWidth: 200,
    direction: TextDirection.ltr,
    contentScrollAxis: Axis.vertical,
    changePageDuration: Duration(milliseconds: 500),
    tabData: <TabData>[],
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
            child: SafeArea(child: Container(child: vtabs)),
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
