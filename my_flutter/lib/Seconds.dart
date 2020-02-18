import 'package:flutter/material.dart';
import 'dart:convert';
import './f_f_entity.dart';

class Seconds extends StatefulWidget {
  static const RouteName = "/seconds";
  String p;

  Seconds(this.p){
    print("hahha"+p);
  }

  @override
  _SecondsState createState() => _SecondsState();
}

class _SecondsState extends State<Seconds> {
  FFEntity ent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      ent=FFEntity.fromJson(new Map<String, dynamic>.from(json.decode( widget.p)));
    });
  }

  @override
  Widget build(BuildContext context) {
//    var strName = ModalRoute.of(context).settings.arguments;
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("第二个页面" + ent.value),
        centerTitle: true,
      ),
      body: MyList(items: new List<String>.generate(50, (i) => "item $i")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
//          Navigator.push(context,
//          MaterialPageRoute(builder: (context) => new NavigationHome()))
        },
        tooltip: "下一个页面",
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}

class MyList extends StatelessWidget {
  final List<String> items;

  MyList({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return new ListTile(
          leading: Icon(Icons.accessible),
          subtitle: new Text('subtitle ${items[index]} $index'),
          title: new Text('${items[index]}'),
//          onTap: ,
          trailing: Icon(Icons.battery_alert),
        );
      },
    );
  }
}
