import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:my_flutter/eventbus/TabViewChangeEvent.dart';
import 'package:my_flutter/utils/ColorUtils.dart';

class BaseTitleBar extends StatelessWidget {

  String title;
  String leftIcon = 'images/black_back.png';
  String rightIconUrl;
  String rightText;
  final Function rightClick,leftBackClick;

  ///中间自定义控件
  Widget centerView;


  BaseTitleBar(this.title,
      {this.leftIcon='images/black_back.png',this.leftBackClick,
      this.rightText,this.rightIconUrl,
      this.centerView,this.rightClick});

  @override
  Widget build(BuildContext context) {
    return new AppBar(
//      flexibleSpace: Container(
//        /// 实现渐变色的效果
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            colors: [
//              Color.fromRGBO(26, 155, 214, 1),
//              Color.fromRGBO(54, 209, 193, 1)
//            ],
//          ),
//        ),
//      ),
      title:  Text(this.title,style: TextStyle(fontSize: 16,color: ColorUtils.appbarTitleColor),),
      leading: new IconButton(
        /// 左边图标，视情况而定，参数
        icon: Image.asset(leftIcon,width: 22,height: 18,fit: BoxFit.contain,),
        color: Colors.white,
        onPressed: () {
          if(this.leftBackClick!=null){
            this.leftBackClick();
          }else{
            Navigator.pop(context);
          }
        },
      ),
      brightness: Brightness.dark,
      elevation: 0.0,
      centerTitle: true,
      actions: <Widget>[
        /// 右边的 布局，自己可以添加，是一个widget的一个集合，自已需求添加即可，我这里写了一个Text，和text的点击事件，
        new RightView(title: rightText,rightIconUrl: this.rightIconUrl, rightClick: rightClick),
      ],
    );
  }
}

/// 中间list 布局，以及点击事件
///暂时不用
class CenterFullView extends StatefulWidget {
  List<String> titleList;
  VoidCallback rightClick;
  Function selectedTab;
  String defTitle;
  EventBus eventBus;
  CenterFullView(
      {this.titleList, this.rightClick, this.selectedTab, this.defTitle,this.eventBus});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CenterState(
        title: titleList,
        rightClick: rightClick,
        selectedBack: this.selectedTab,
        selectedTitle: this.defTitle,eventBus: this.eventBus);
  }
}

class CenterState extends State<CenterFullView> {
  List<String> title;
  VoidCallback rightClick;
  Function selectedBack;
  Color defColor = Colors.transparent;
  Color selColor = Colors.white;

  Color defTitleColor = Colors.grey;
  Color selTitleColor = Colors.white;
  String selectedTitle;
  int selectedIndex;
  EventBus eventBus;

  StreamSubscription streamSubscription;
  CenterState(
      {this.title, this.rightClick, this.selectedBack, this.selectedTitle,this.eventBus});

  Color _titleColor(String t) {
    if (selectedTitle == t) {
      return this.selTitleColor;
    } else {
      return this.defTitleColor;
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
    if(streamSubscription!=null){
      streamSubscription.cancel();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    selectedTitle = this.title[0];
    super.initState();
    streamSubscription= this.eventBus.on<TabViewChangeEvent>().listen((event) {
      if(event.index!=this.selectedIndex){
        print("===========eventbus========");
        print(event.selected);
        setState(() {
          selectedTitle = event.selected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var containView;
    if (title != null) {
      containView = new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: title.map((t) {
            return GestureDetector(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      t,
                      style: TextStyle(fontSize: 16, color: _titleColor(t)),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 12, left: 3),
                      height: 4,
                      width: 50, // MediaQuery.of(context).size.width - 140,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.8, color: _underLineColor(t)))
//              border: Border.all(color: Colors.grey,width: 0.5),
//              borderRadius: BorderRadius.circular(5),
                          ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(top: 24, right: 12),
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
  String title;
  String rightIconUrl;
  Function rightClick;

  RightView({this.title, this.rightIconUrl ,this.rightClick});

  @override
  Widget build(BuildContext context) {
    var containView;
    if (title != null) {
      containView = new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
          child: Text(
            this.title,
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          ),
          onTap: this.rightClick,
        ),
      );
    } else if(rightIconUrl!=null){
      containView = new GestureDetector(child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: 40),
        padding: EdgeInsets.all(10.0),
        child: Image.asset(this.rightIconUrl,
              height: 22, width: 22, fit: BoxFit.contain),
      ), onTap: this.rightClick,);
    } else {
      containView = Text("");
    }
    return containView;

  }
}
