import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rum_logger_client/service/user_service.dart';
import 'package:rum_logger_client/view/user_content.dart';

import 'add_keywords_widget.dart';

class TabData {
  final Tab tab;
  UserContent content;
  final int id;
  GlobalKey<UserContentState> globalKey;

  TabData(this.tab, this.content, this.id, this.globalKey);
}

/// A vertical tab widget for flutter
class VerticalTabs extends StatefulWidget {
  bool loading = false;
  final Key? key;
  final double tabsWidth;
  final double itemExtent;
  final double indicatorWidth;
  List<TabData>? tabData = [];
  final TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color selectedTabBackgroundColor;
  final Color unselectedTabBackgroundColor;
  final Color dividerColor;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final Color tabsShadowColor;
  final double tabsElevation;
  VerticalTabs(
      {this.key,
      this.tabData,
      this.tabsWidth = 200,
      this.itemExtent = 50,
      this.indicatorWidth = 3,
      this.direction = TextDirection.ltr,
      this.indicatorColor = Colors.orangeAccent,
      this.disabledChangePageFromContentView = false,
      this.contentScrollAxis = Axis.horizontal,
      this.selectedTabBackgroundColor = Colors.white10,
      this.unselectedTabBackgroundColor = const Color(0xfff8f8f8),
      this.dividerColor = const Color(0xffe5e5e5),
      this.changePageCurve = Curves.easeInOut,
      this.changePageDuration = const Duration(milliseconds: 300),
      this.tabsShadowColor = Colors.black54,
      this.tabsElevation = 2.0})
      : super(key: key);
  @override
  _VerticalTabsState createState() => _VerticalTabsState();
}

class _VerticalTabsState extends State<VerticalTabs>
    with TickerProviderStateMixin {
  UserService userService = UserService();
  int _selectedIndex = 0;
  late bool? _changePageByTapView;
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;
  PageController pageController = PageController();
  List<AnimationController> animationControllers = [];
  ScrollPhysics pageScrollPhysics = AlwaysScrollableScrollPhysics();
  @override
  void initState() {
    for (int i = 0; i < widget.tabData!.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    _selectTab(0);

    pageScrollPhysics = NeverScrollableScrollPhysics();
    super.initState();
    const oneSec = Duration(seconds: 1);

    var index = _selectedIndex;
    Timer.periodic(
        oneSec,
        (Timer t) => userService.GetUserLogs(widget.tabData![_selectedIndex].id,
                widget.tabData![_selectedIndex].content.description.Log)
            .then((value) => {
                  setState(() {
                    widget.tabData![_selectedIndex].globalKey.currentState!
                        .refresh(value);
                  })
                }));
  } //TODO make id safe

  @override
  Widget build(BuildContext context) {
    var logo = Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage('assets/logo-2.png'),
            width: 300,
          ),
          Divider(
            height: 5,
            color: Colors.black45,
          ),
        ],
      ),
    );

    var leftMenu = Material(
      child: Container(
        width: widget.tabsWidth,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderOnForeground: true,
                    color: widget.indicatorColor,
                    elevation: widget.tabsElevation,
                    shadowColor: widget.tabsShadowColor,
                    shape: BeveledRectangleBorder(),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(child: Center(child: Text('Users'))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemExtent: widget.itemExtent,
                itemCount: widget.tabData!.length,
                itemBuilder: (context, index) {
                  Tab tab = widget.tabData![index].tab;
                  Alignment alignment = Alignment.centerLeft;
                  if (widget.direction == TextDirection.rtl) {
                    alignment = Alignment.centerRight;
                  }
                  Widget child;
                  if (tab.child != null) {
                    child = tab.child!;
                  } else {
                    child = Row(
                      children: <Widget>[
                        (tab.icon != null)
                            ? Row(
                                children: <Widget>[
                                  tab.icon!,
                                  const SizedBox(
                                    width: 5,
                                  )
                                ],
                              )
                            : Container(),
                        if (tab.text != null) Text(tab.text!) else Container(),
                      ],
                    );
                  }
                  Color itemBGColor = widget.unselectedTabBackgroundColor;
                  if (_selectedIndex == index) {
                    itemBGColor = widget.selectedTabBackgroundColor;
                  }
                  return GestureDetector(
                    onTap: () {
                      _changePageByTapView = true;
                      setState(() {
                        _selectTab(index);
                      });
                      pageController.animateToPage(index,
                          duration: widget.changePageDuration,
                          curve: widget.changePageCurve);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: itemBGColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ScaleTransition(
                            child: Container(
                              width: widget.indicatorWidth,
                              height: widget.itemExtent,
                              color: widget.indicatorColor,
                            ),
                            scale: Tween(begin: 0.0, end: 1.0).animate(
                              new CurvedAnimation(
                                parent: animationControllers[index],
                                curve: Curves.elasticOut,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: alignment,
                              padding: EdgeInsets.all(5),
                              child: child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      elevation: widget.tabsElevation,
      shadowColor: widget.tabsShadowColor,
      shape: BeveledRectangleBorder(),
    );

    var rightView = Expanded(
      child: Column(
        children: [
          AddNewKeywordsWidget(userService: userService),
          Divider(
            height: 5,
            color: Colors.black45,
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: widget.contentScrollAxis,
              physics: pageScrollPhysics,
              onPageChanged: (index) {
                if (_changePageByTapView == false ||
                    _changePageByTapView == null) {
                  _selectTab(index);
                }
                if (_selectedIndex == index) {
                  _changePageByTapView = null;
                }
                setState(() {});
              },
              controller: pageController,
              // the number of pages
              itemCount: widget.tabData!.length,
              // building pages
              itemBuilder: (BuildContext context, int index) {
                return widget.tabData![index].content;
              },
            ),
          ),
        ],
      ),
    );

    return Directionality(
      textDirection: widget.direction,
      child: Column(
        children: <Widget>[
          logo,
          Expanded(
            child: Row(
              children: <Widget>[
                leftMenu,
                rightView,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(index) {
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    userService.GetUserLogs(widget.tabData![index].id,
            widget.tabData![index].content.description.Log)
        .then((value) => {
              setState(() {
                widget.tabData![index].content.description = value;
              })
            });

    animationControllers[index].forward();
  }
}
