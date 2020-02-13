
import 'package:flutter/material.dart';



class Seconds extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Secondss(),
    );
  }
}


class Secondss extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SecondsState();
  }
}
class SecondsState extends State<Secondss>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(padding: EdgeInsets.all(10.0),child: Text('哈哈哈'),);
  }

}