import 'package:flutter/material.dart';
import 'package:my_flutter/inherited/InheritedWidgetData.dart';
import 'package:my_flutter/inherited/InheritedWidgetDemo.dart';

class CenterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CenterWidgetState();
}

class _CenterWidgetState extends State<CenterWidget> {
  InheritedWidgetData _userData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userData = InheritedWidgetDemo.of(context);
    _getUserData();
  }

  _getUserData() async {
    ///模拟网络请求 等待五秒
    await Future.delayed(Duration(seconds: 3));
    InheritedWidgetDemo.of(context).setUser("李华", 18);
    ///setState 触发页面刷新
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      /// 数据为空显示加载圆圈
      child: _userData.userName == ""
          ? CircularProgressIndicator()
          : new UserInfoWidget(),
    );
  }
}

///用户信息Widget
class UserInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoWidget> {
  InheritedWidgetData _userData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userData = InheritedWidgetDemo.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text(_userData.userName),
          new Text(_userData.userAge.toString())
        ],
      ),
    );
  }
}