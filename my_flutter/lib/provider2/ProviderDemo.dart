import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Counter.dart';
import 'ProviderSeconds.dart';
class ProviderDemo extends StatelessWidget{
  ProviderDemo( {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return MultiProvider(providers: [
      ChangeNotifierProvider<Counter>(
        create: (context)=>Counter(),
      ),
//      Provider.value(value: Counter()),
    ],child:MaterialApp(home: ProviderView()
    ),);
  }
}

class ProviderView extends StatefulWidget{
  ProviderView( {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProviderState();
  }
}
class ProviderState extends State<ProviderView>{
//顶层依赖
//  var counter = Counter();
  int textSize=48;
  @override
  void initState() {
    // TODO: implement initState
//    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    print('ssss');
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('provider'),
          centerTitle: true,
          leading: BackButton(),
        ),
        body: Column(children: <Widget>[
          Text('provider',style: TextStyle(fontSize: textSize.toDouble(),color: Colors.blue),),
          OutlineButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (b){
              return ProviderSeconds();
            }));
          },child: Text('button'),),
          Consumer<Counter>(builder:(context,Counter a,_){
            print('sdfj;lsakj');
            return Text('${a.value.toString()}');
          }),
          abc(),
          Consumer<Counter>(builder:(context,Counter a,Widget ch)=>OutlineButton(onPressed: (){
            a.increment();
          },child: ch,),child:  Text('add +'),),
          OutlineButton(onPressed: (){
            Provider.of<Counter>(context, listen: false).increment();
          },child: Text('add +'),)
        ],));
  }
  abc(){
    print('ceshi');
    return Text('ceshi');
  }
}