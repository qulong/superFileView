
import 'package:flutter/material.dart';
import 'package:my_flutter/inherited/InheritedWidgetData.dart';
import 'package:my_flutter/inherited/InheritedWidgetDemo.dart';

class EditUserPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("修改数据"),
      ),
      body: new EditUserWidget(),
    );
  }
}

class EditUserWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditUserState();
}

class _EditUserState extends State<EditUserWidget> {
  InheritedWidgetData _userData;
  String _userName;
  String _userAge;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userData = InheritedWidgetDemo.of(context);
    _userName = _userData.userName;
    if (_userData.userAge > 0) {
      _userAge = _userData.userAge.toString();
    } else {
      _userAge = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextField(
            ///文本内容控制器
            controller: TextEditingController.fromValue(new TextEditingValue(
              text: _userName,
              ///光标移动到最后面
              selection: TextSelection.fromPosition(new TextPosition(
                  affinity: TextAffinity.downstream, offset: _userName.length)),
            )),

            decoration: new InputDecoration(labelText: "输入姓名"),

            ///内容变化监听
            onChanged: (value) {
              _userName = value;
            },
          ),
          new TextField(
            ///文本内容控制器
            controller: TextEditingController.fromValue(new TextEditingValue(
              text: _userAge,
              ///光标移动到最后面
              selection: TextSelection.fromPosition(new TextPosition(
                  affinity: TextAffinity.downstream, offset: _userAge.length)),
            )),

            decoration: new InputDecoration(labelText: "输入年龄"),

            ///内容变化监听
            onChanged: (value) {
              _userAge = value;
            },
          ),
          new FlatButton(
              onPressed: () {
                int userAge;
                try {
                  ///保存当前修改的值
                  userAge = int.parse(_userAge);
                  InheritedWidgetDemo.of(context).setUser(_userName, userAge);
                  ///关闭当前界面
                  Navigator.pop(context);
                } catch (e) {}
              },
              child: new Text("保存"))
        ],
      ),
    );
  }
}