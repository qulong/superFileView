import 'package:flutter/material.dart';
import 'package:my_flutter/inherited/CenterWidget.dart';
import 'package:my_flutter/inherited/EditUserPageWidget.dart';
import 'package:my_flutter/inherited/InheritedWidgetData.dart';
import 'package:my_flutter/inherited/InheritedWidgetDemo.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new InheritedWidgetDemo(
        data: new InheritedWidgetData(),
        child: new MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new Scaffold(
            appBar: new AppBar(
              title: new Text("数据传递"),
            ),
            floatingActionButton: new Builder(builder: (context) {
              return new FloatingActionButton(
                  child: new Icon(Icons.edit),
                  onPressed: () {
                    ///push到编辑页面
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (BuildContext context) {
                          return EditUserPageWidget();
                        }));
                  });
            }),
            body: new CenterWidget(),
          ),
        ));
  }
}
