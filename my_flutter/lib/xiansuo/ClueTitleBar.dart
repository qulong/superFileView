import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:my_flutter/eventbus/TabViewChangeEvent.dart';

class ClueTitleBar extends StatelessWidget {
  final Function rightClick;
  final Function selectedClick;
  List<String> centerTabTitle;
  String defSelect;
  EventBus eventBus;
  ClueTitleBar(this.selectedClick,
      {this.centerTabTitle, this.rightClick, this.defSelect, this.eventBus});

  Widget centerTitle() {
    if (this.centerTabTitle != null && this.centerTabTitle.length > 0) {
      return CenterFullView(
        title: this.centerTabTitle,
        rightClick: this.rightClick,
        selectedTab: this.selectedClick,
        defTitle: this.defSelect,
        eventBus: this.eventBus,
      );
    } else {
      return new Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      flexibleSpace: Container(
        /// 实现渐变色的效果
        decoration: BoxDecoration(
          color: Colors.white70,
//          gradient: LinearGradient(
//            colors: [
//              Color.fromRGBO(26, 155, 214, 1),
//              Color.fromRGBO(54, 209, 193, 1)
//            ],
//          ),
        ),
        child: centerTitle(),
      ),
      leading: new IconButton(
        /// 左边图标，视情况而定，参数
        icon: Image.asset('images/black_back.png',width: 22,height: 18,fit: BoxFit.contain,),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0.0,
      centerTitle: true,
      actions: <Widget>[
        /// 右边的 布局，自己可以添加，是一个widget的一个集合，自已需求添加即可，我这里写了一个Text，和text的点击事件，
        new RightView(rightClick: rightClick),
      ],
    );
  }
}

/// 中间list 布局，以及点击事件
///
class CenterFullView extends StatefulWidget {
  List<String> title;
  Function rightClick;
  Function selectedTab;
  String defTitle;
  EventBus eventBus;
  CenterFullView(
      {this.title,
      this.rightClick,
      this.selectedTab,
      this.defTitle,
      this.eventBus});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CenterState(
        title: title,
        rightClick: rightClick,
        selectedBack: this.selectedTab,
        selectedTitle: this.defTitle,
        eventBus: this.eventBus);
  }
}

class CenterState extends State<CenterFullView> {
  List<String> title;
  Function rightClick;
  Function selectedBack;
  Color defColor = Colors.white;
  Color selColor = Color.fromRGBO(68, 68, 68, 1);

  Color defTitleColor = Color.fromRGBO(68, 68, 68, 0.6);
  Color selTitleColor = Color.fromRGBO(68, 68, 68, 1);
  String selectedTitle;
  int selectedIndex;
  EventBus eventBus;

  StreamSubscription streamSubscription;
  CenterState(
      {this.title,
      this.rightClick,
      this.selectedBack,
      this.selectedTitle,
      this.eventBus});

  Color _titleColor(String t) {
    if (selectedTitle == t) {
      return this.selTitleColor;
    } else {
      return this.defTitleColor;
    }
  }

  double _fontSize(String t) {
    if (selectedTitle == t) {
      return 19;
    } else {
      return 14;
    }
  }

  Color _underLineColor(String t) {
    if (selectedTitle == t) {
      return this.selColor;
    } else {
      return this.defColor;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (streamSubscription != null) {
      streamSubscription.cancel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedTitle = this.title[0];
    super.initState();
    streamSubscription = this.eventBus.on<TabViewChangeEvent>().listen((event) {
      if (event.index != this.selectedIndex) {
        print("===========eventbus========");
        print(event.selected);
        setState(() {
          selectedTitle = event.selected;
          selectedIndex=event.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var containView;
    if (title != null) {
      containView = new Container(
        alignment: Alignment.bottomCenter,
        padding:EdgeInsets.only(top: 24) ,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: title.map((t) {
            return GestureDetector(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        t,
                        style: TextStyle(
                            fontSize: _fontSize(t), color: _titleColor(t)),
                      ),
                      alignment: Alignment.center,
                      width: 100,
                      height: 36,
                    ),
                    new Container(
                      color: _underLineColor(t),
                      margin: EdgeInsets.only(top: 8),
                      height: 4,
                      width: 20, // MediaQuery.of(context).size.width - 140,
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  selectedTitle = t;
                  selectedIndex = title.indexOf(t);
                });
                if (this.selectedBack != null) {
                  this.selectedBack(t, selectedIndex);
                }
              },
            );
          }).toList(),
        ),
      );
    } else {
      containView = Text("");
    }
    return containView;
  }
}

/// 右边的 布局，以及点击事件
class RightView extends StatelessWidget {
  Function rightClick;
///this.rightClick(0) 0待处理，1已处理
  RightView({this.rightClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(onTap: (){this.rightClick(0) ;},child:
          Image.asset('images/right_search.png',
              height: 22, width: 22, fit: BoxFit.contain),),
          GestureDetector(onTap: (){this.rightClick(1) ;},child: Container(child: Image.asset('images/filter_icon.png',width: 20,height: 22,),margin: EdgeInsets.only(left: 10,right: 6),),)
        ],
      ),
    );
  }
}
