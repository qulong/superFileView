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
  final Function rightClick, leftBackClick;

  ///中间自定义控件
  Widget centerView;

  BaseTitleBar(this.title,
      {this.leftIcon = 'images/black_back.png',
      this.leftBackClick,
      this.rightText,
      this.rightIconUrl,
      this.centerView,
      this.rightClick});

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
      title:_centerTitlewidget(),
      leading: new IconButton(
        /// 左边图标，视情况而定，参数
        icon: Image.asset(
          leftIcon,
          width: 22,
          height: 18,
          fit: BoxFit.contain,
        ),
        color: Colors.white,
        onPressed: () {
          if (this.leftBackClick != null) {
            this.leftBackClick();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      brightness: Brightness.dark,
      elevation: 0.0,
      centerTitle: true,
      actions: <Widget>[
        /// 右边的 布局，自己可以添加，是一个widget的一个集合，自已需求添加即可，我这里写了一个Text，和text的点击事件，
        new RightView(
            title: rightText,
            rightIconUrl: this.rightIconUrl,
            rightClick: rightClick),
      ],
    );
  }

  Widget _centerTitlewidget(){
    if(this.centerView!=null){
      return this.centerView;
    }else{
      return Text(
        this.title,
        style: TextStyle(fontSize: 16, color: ColorUtils.appbarTitleColor),
      );
    }
  }
}

/// 中间list 布局，以及点击事件
///暂时不用
class CenterFullView extends StatefulWidget {
  String defTitle;
  Function clickCall;
  String iconUrl;
  CenterFullView({this.defTitle, this.clickCall, this.iconUrl});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CenterState(
        defTitle: this.defTitle,
        clickCall: this.clickCall,
        iconUrl: this.iconUrl);
  }
}

class CenterState extends State<CenterFullView> {
  String defTitle;
  Function clickCall;
  String iconUrl;
  CenterState({this.defTitle, this.clickCall, this.iconUrl});

  @override
  Widget build(BuildContext context) {
    var containView;
    if (defTitle != null) {
      containView = GestureDetector(
        onTap: () {this.clickCall();},
        child: new Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                this.defTitle,
                style: TextStyle(fontSize: 16, color: ColorUtils.c333333),
              ),
             Container(margin: EdgeInsets.only(left: 8),child:  Image.asset(
               this.iconUrl,
               width: 10,
               height: 8,
               fit: BoxFit.cover,
             ),)
            ],
          ),
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

  RightView({this.title, this.rightIconUrl, this.rightClick});

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
    } else if (rightIconUrl != null) {
      containView = new GestureDetector(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 40),
          padding: EdgeInsets.all(10.0),
          child: Image.asset(this.rightIconUrl,
              height: 22, width: 22, fit: BoxFit.contain),
        ),
        onTap: this.rightClick,
      );
    } else {
      containView = Text("");
    }
    return containView;
  }
}
