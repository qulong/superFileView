import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Counter.dart';
class ProviderSeconds extends StatelessWidget{
  ProviderSeconds( {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderSecondsView();
  }
}

class ProviderSecondsView extends StatefulWidget{
  ProviderSecondsView( {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProviderSecondsState();
  }
}
class ProviderSecondsState extends State<ProviderSecondsView>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('provider'),
          centerTitle: true,
          leading: BackButton(),
        ),
        body: Column(children: <Widget>[
          Consumer<Counter>(builder:( context,Counter a,_){
            return Text(a.value.toString());
          }),
          Consumer<Counter>(builder:(context,Counter a,Widget ch)=>OutlineButton(onPressed: (){
            a.increment();
          },child: ch,),child:  Text('add +'),),
//TextField(focusNode: FocusNode(canRequestFocus: false),onChanged: (t){
//Provider(create: (ad)=>12,);
//},)
        ],));
  }
}