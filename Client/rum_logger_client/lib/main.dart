import 'package:flutter/material.dart';
import 'package:rum_logger_client/view/main_page.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Scaffold(
        body: MainPage(),
      ),
    );
  }
}
