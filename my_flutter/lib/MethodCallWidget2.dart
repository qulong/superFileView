import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './utils/Toast.dart';

class MethodCallWidget2 extends StatefulWidget {
//  static const RouteName = "/seconds";

  @override
  _MethodCallWidgetState createState() => _MethodCallWidgetState();
}

class _MethodCallWidgetState extends State<MethodCallWidget2> {
  MethodChannel _methodChannel = MethodChannel("channel2");
  String _content;

  @override
  void initState() {
    // TODO: implement initState
    _methodChannel.setMethodCallHandler((handler) => Future<String>(() {
          print("_methodChannel：${handler}");
          //监听native发送的方法名及参数
          switch (handler.method) {
            case "send2":
              _send(handler.arguments); //handler.arguments表示native传递的方法参数
              break;
          }
        }));
    super.initState();
    Future.delayed(Duration(seconds: 1), () => _sendToNative());
  }

//native调用的flutter方法
  void _send(arg) {
    setState(() {
      _content = arg;
    });
  }

  String _resultContent = "";

  //flutter调用native的相应方法
  void _sendToNative() async {
    Future<String> future =
        _methodChannel.invokeMethod("send2", "flutter 给Android 的value");
    future.then((message) {
      print("fanfanfan 2 " + message);
      setState(() {
        //message是native返回的数据
        _resultContent = "2返回值：" + message;
      });
    });
  }

  //flutter调用native的相应方法
  void _loadNativeData() async {
    Future<String> future =
    _methodChannel.invokeMethod("loadData", "load Data go");
    future.then((message) {
      print("loadData from native " + message);
      setState(() {
        //message是native返回的数据
        _resultContent = "load：" + message;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
//    var strName = ModalRoute.of(context).settings.arguments;
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("第二个页面method call 2" + _resultContent),
        centerTitle: true,
      ),
      body: MyList(items: new List<String>.generate(50, (i) => "哈22哈哈 $i")),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
          ok()
//          Navigator.push(context,
//          MaterialPageRoute(builder: (context) => new NavigationHome()))
        ,
        tooltip: "下一个页面",
        child: Icon(Icons.ac_unit),
      ),
    );
  }
  void ok(){
    Toast.toast(context, "哈哈哈哈哈");
    _loadNativeData();
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
