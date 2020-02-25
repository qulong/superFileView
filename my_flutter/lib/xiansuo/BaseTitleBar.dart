import 'package:flutter/material.dart';

class BaseTitleBar extends StatelessWidget {
  String title;
  IconData leftIcon = Icons.arrow_back_ios;
  String rightText;
  final VoidCallback rightClick;
  final Function selectedClick;
  List<String> centerTabTitle;

  BaseTitleBar(this.title,this.selectedClick,
      {this.leftIcon, this.rightText, this.centerTabTitle, this.rightClick});

  Widget centerTitle() {
    if (this.centerTabTitle != null && this.centerTabTitle.length > 0) {
      return CenterFullView(
          title: this.centerTabTitle, rightClick: this.rightClick,selectedTab: this.selectedClick,);
    } else {
      return new Text(this.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      flexibleSpace: Container(
        /// 实现渐变色的效果
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(26, 155, 214, 1),
              Color.fromRGBO(54, 209, 193, 1)
            ],
          ),
        ),
        child: centerTitle(),
      ),
      leading: new IconButton(
        /// 左边图标，视情况而定，参数
        icon: Icon(this.leftIcon),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      brightness: Brightness.dark,
      elevation: 2.0,
      centerTitle: true,
      actions: <Widget>[
        /// 右边的 布局，自己可以添加，是一个widget的一个集合，自已需求添加即可，我这里写了一个Text，和text的点击事件，
        new RightView(title: rightText, rightClick: rightClick),
      ],
    );
  }
}

/// 中间list 布局，以及点击事件
///
class CenterFullView extends StatefulWidget {
  List<String> title;
  VoidCallback rightClick;
Function selectedTab;
  CenterFullView({this.title, this.rightClick,this.selectedTab});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CenterState(title: title, rightClick: rightClick,selectedBack: this.selectedTab);
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
  CenterState({this.title, this.rightClick,this.selectedBack});

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
  void initState() {
    // TODO: implement initState
    selectedTitle = this.title[0];
    super.initState();
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
                });
                if(this.selectedBack!=null){
                  this.selectedBack(t);
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
  VoidCallback rightClick;

  RightView({this.title, this.rightClick});

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
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onTap: this.rightClick,
        ),
      );
    } else {
      containView = Text("");
    }
    return containView;
  }
}
