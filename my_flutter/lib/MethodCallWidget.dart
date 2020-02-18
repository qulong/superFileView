import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodCallWidget extends StatefulWidget {
//  static const RouteName = "/seconds";

  @override
  _MethodCallWidgetState createState() => _MethodCallWidgetState();
}

class _MethodCallWidgetState extends State<MethodCallWidget> {
  MethodChannel _methodChannel = MethodChannel("gogogo");
  String _content;

  @override
  void initState() {
    // TODO: implement initState
    _methodChannel.setMethodCallHandler((handler) => Future<String>(() {
          print("_methodChannel：${handler}");
          //监听native发送的方法名及参数
          switch (handler.method) {
            case "send":
              _send(handler.arguments); //handler.arguments表示native传递的方法参数
              break;
          }
        }));
//
//    作者：大逗大人
//    链接：https://juejin.im/post/5d04790a6fb9a07efa09164d
//    来源：掘金
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
//
    super.initState();
Future.delayed(Duration(seconds: 1),()=>{
    _sendToNative()
});

  }

//native调用的flutter方法
  void _send(arg) {
    setState(() {
      _content = arg;
    });
  }

  String _resultContent = "";

  //flutter调用native的相应方法
  void _sendToNative() async{
    Future<String> future =  _methodChannel.invokeMethod("send", "flutter 给Android 的value");
    future.then((message) {
      print("fanfanfan"+message);
      setState(() {
        //message是native返回的数据
        _resultContent = "返回值：" + message;
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
        title: Text("第二个页面method call" + _resultContent),
        centerTitle: true,
      ),
      body: MyList(items: new List<String>.generate(50, (i) => "哈哈哈 $i")),
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
