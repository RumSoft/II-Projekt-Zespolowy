import 'package:flutter/material.dart';

import 'vertical_tab.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: VerticalTabs(
        tabsWidth: 80,
        direction: TextDirection.ltr,
        contentScrollAxis: Axis.vertical,
        changePageDuration: Duration(milliseconds: 500),
        tabs: <Tab>[
          Tab(child: Text('Flutter')),
          Tab(child: Text('Dart')),
          Tab(child: Text('NodeJS')),
          Tab(child: Text('PHP')),
        ],
        contents: <Widget>[
          tabsContent('Flutter', 'www.fluttertutorial.in'),
          tabsContent('Dart'),
          tabsContent('NodeJS'),
          tabsContent('PHP'),
        ],
      ),
    ));
  }

  Widget tabsContent(String caption, [String description = '']) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(fontSize: 25),
          ),
          Divider(
            height: 20,
            color: Colors.black45,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
