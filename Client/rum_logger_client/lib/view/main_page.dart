import 'package:flutter/material.dart';
import 'package:rum_logger_client/service/user_service.dart';

import 'vertical_tab.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
          child: Container(
        width: 1200,
        child: VerticalTabs(
          tabsWidth: 120,
          direction: TextDirection.ltr,
          contentScrollAxis: Axis.vertical,
          changePageDuration: Duration(milliseconds: 500),
          tabData: <TabData>[
            TabData(Tab(child: Text('Flutter1')),
                tabsContent('Flutter1', 'www.fluttertutorial.in')),
          ],
        ),
      )),
    );
  }

  List<TabData> GetUserList() {
    var userService = UserService();
    List<TabData> list = <TabData>[];
    var users = userService.GetUserList().then((value) => {
          for (var item in value)
            {
              list.add(TabData(Tab(child: Text('Flutter1')),
                  tabsContent('Flutter1', 'www.fluttertutorial.in')))
            }
        });
    return list;
  }

  Widget tabsContent(String caption, [String description = '']) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Text(
            caption,
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
                          child: Text('data',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white)),
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
                        child: Text('data',
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
