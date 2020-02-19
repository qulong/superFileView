import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'UrlApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './beans/CommentData.dart';
import './beans/LoginBeans.dart';
import './beans/json_bean_login_entity.dart';

class LoginAct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginStatus();
  }
}

class LoginStatus extends State<LoginAct> {
  String phoneNumber = '';
  String pwd = '';
  @override
  Widget build(BuildContext context) {
//    final controller = TextEditingController();
//    controller.addListener(() {
//      print('input ${controller.text}');
//    });

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => {Navigator.of(context).pop(1)},
        ),
        title: Text("登录"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 40, maxWidth: 300),
            child: TextField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                onChanged: (text) {
                  setState(() {
                    phoneNumber = text;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                  hintText: '请输入手机号码',
//              prefixIcon: Icon(Icons.search),
                  // contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xffaaaaaa),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Theme(
              data: ThemeData(primaryColor: Colors.red, hintColor: Colors.blue),
              child: TextField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                obscureText: true, //是否是密码
                maxLength: 8,
                maxLines: 1,
                onChanged: (text) {
                  setState(() {
                    pwd = text;
                  });
                },
                style: TextStyle(fontSize: 16, color: Colors.amber),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12), //EdgeInsets.all(5.0)
                    counter: null,
                    counterText: '',
                    hintText: "输入密码",
                    suffix: Icon(Icons.close),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
//            borderSide: BorderSide(color: Colors.red, width: 3.0, style: BorderStyle.solid)//没什么卵效果
                    )),
              ),
            ),
          ),
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名或邮箱",
                prefixIcon: Icon(Icons.person)),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)),
            obscureText: true,
          ),
          TextField(
            maxLength: 30, //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
            maxLines: 1, //最大行数
            autocorrect: true, //是否自动更正
            obscureText: true, //是否是密码
            textAlign: TextAlign.center,
            //文本对齐方式
            style: TextStyle(fontSize: 10.0, color: Colors.blue),
            //输入文本的样式
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly
            ], //允许的输入格式
            onChanged: (text) {
              //内容改变的回调
              print('change $text');
            },
            onSubmitted: (text) {
              //内容提交(按回车)的回调
              print('submit $text');
            },
            enabled: true, //是否禁用
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            width: 300,
            child: FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("Submit"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                _submit();
              },
            ),
          )
        ],
      ),
    );
  }

  void _submit() {
    print("length:" + phoneNumber ?? "".length.toString());
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      print(phoneNumber);
    }
    if (pwd.isNotEmpty) {
      print("pwd:=" + pwd);
    }
    loadData();
    loginLoading();
  }

  void loadData() async {
    Dio dio = Dio();
    Response response = await dio
        .post(UrlApi.GETSECURITYCODE, data: {"phoneNumber": '15701152205'});
    print("=====================org+++++++++++++++++");
    print(response);
    var bean=response.data['data'];
    //{"result":true,"errcode":"","msg":"操作成功!","data":{"outId":"6e70a0fc179d401780e136b396a8fb42"}}
//    var bean = {"result": true, "errcode": "", "msg": "操作成功!", "data": {}};
     Map<String,dynamic> d = bean['data'];
    var id = d['outId'];
    print(id);
    print("获取验证码：" + bean['msg']);
//loginLoading();
  }
  void loginLoading() async{
    Dio dio = Dio();
    Response response = await dio
        .post(UrlApi.GETLOGIN, data: {"phoneNumber": '15701152205','securityCode':'123456',"source": "android"});
    print("=====================org+++++++++++++++++");
    print(response.data['msg']);
    print(response.data['data'].toString());
    var datas=response.data['data'];
    if(datas!=null&&datas!=""){
     bool ok= datas is String ;
     print("string ok:"+ok.toString());
     bool kk=datas is Object;
     print("kkk"+kk.toString());
    }

  }
  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);

  }
}
