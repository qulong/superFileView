import 'package:flutter/material.dart';
import 'package:my_flutter/utils/MyLog.dart';
import 'package:my_flutter/xiansuo/BaseTitleBar.dart';
import 'package:my_flutter/xiansuo/BaseViewBar.dart';

class TabClue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewChild();
  }
}

class ViewChild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateViewChild();
  }
}

class StateViewChild extends State<ViewChild> {
 List<String> titleList= ['无用的','有用的'];


 @override
 void initState() {
   // TODO: implement initState
   super.initState();
   MyLog.init(isDebug: true,title: 'tabview');
 }
  _selectedCallBack(title){
    MyLog.d(title);

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar:BaseViewBar(preferredSize:Size.fromHeight(50.0), childView:BaseTitleBar('s',_selectedCallBack, leftIcon: Icons.arrow_back,centerTabTitle: this.titleList)),
//          appBar: new TabBar(
//            isScrollable: true,
//            tabs: choices.map((Choice choice) {
//              return new Tab(
//                text: choice.title,
//                icon: new Icon(choice.icon),
//              );
//            }).toList(),
//          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MyTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: <Widget>[
      BackButton(
        onPressed: () {},
      ),
      Row(children: <Widget>[
        BackButton(
          onPressed: () {},
        ),
      ])
    ]);
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
