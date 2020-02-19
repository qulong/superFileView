import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Seconds.dart';
import './RouteFlutter.dart';
import './f_f_entity.dart';
import './MethodCallWidget.dart';
import './MethodCallWidget2.dart';
import './dyrs/LoginAct.dart';

void main() => runApp(MyApp());

//void main(){
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//      .then((_){
//    runApp(new MyApp());
//  });
//}
Widget _widgetForRoute(String route) {
  String def="";
  String params=null;
  if(route.startsWith("@")){
    List<String> sp=route.split("@");
    def= sp[1];
    print(sp[2]);
    params=sp[2];
//    params= FFEntity.fromJson(new Map<String, dynamic>.from(json.decode(sp[2])));
  }else{
    def=route;
  }
  switch (def) {
    case "seconds":
      return Seconds(params);
    case "methodcallBack":
      return MethodCallWidget();
    case "chan2":
      return MethodCallWidget2();
    case "th":
      return RouteFlutter();

    case "login":
      return LoginAct();

    default:
      return MyHomePage(title: "canshu");
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("#######################################");
    print(window);
    print(window.defaultRouteName);
    return MaterialApp(
      home: _widgetForRoute(window.defaultRouteName),
    );
  }
}
//
//
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
//        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
//
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        leading: BackButton(),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  backgroundColor: Colors.deepPurpleAccent),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: () => jumpNative("Tag1", jsonparam: ""),
              child: Text("跳转到原生指定页面"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void jumpNative(String tag, {String jsonparam}) async{

//     Map<String,String> paramsMap = {"param1": "value1", "param2": "value2", "param3": "value3"};
//      String json = jsonEncode(paramsMap);
  var flutter=FFEntity(name: "测试",value: "哈哈哈哈");
    MyFlutterPlugin.openNativePage(tag, paramsJson: jsonEncode(flutter));
  }
}


class MyFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('com.your.packagename/flutter_plugin');

  /**
   * 打开原生页面
   */
  static Future<String> openNativePage(String target, {String paramsJson}) async {
//    if (paramsMap == null) {
//      paramsMap = Map();
//    }
    return await _channel
        .invokeMethod("openNative", {"target": target, "params": paramsJson});
  }
}
//
//作者：孑孓
//链接：https://juejin.im/post/5c7a26faf265da2da8358eb1
//来源：掘金
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


class ParamsFlutter{
  final String name;
  final String value;
  ParamsFlutter(this.name,this.value);
}