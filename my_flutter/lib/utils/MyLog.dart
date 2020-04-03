import 'package:flutter/cupertino.dart';

class MyLog {
  static var _separator = "=";
  static var _split =
      "$_separator$_separator$_separator$_separator$_separator$_separator$_separator$_separator$_separator";
  static var _title = "Def-Log";
  static bool _isDebug = true;
  static int _limitLength = 800;
  static String _startLine = "$_split$_title$_split";
  static String _endLine = "$_split$_separator$_separator$_separator$_split";

  static void init({String title,bool isDebug=true, int limitLength}) {
    _title = title;
    _isDebug = isDebug;
    _limitLength = limitLength ??= _limitLength;
    _startLine = "$_split$_title$_split";
    var endLineStr = StringBuffer();
    var cnCharReg = RegExp("[\u4e00-\u9fa5]");
    for (int i = 0; i < _startLine.length; i++) {
      if (cnCharReg.stringMatch(_startLine[i]) != null) {
        endLineStr.write(_separator);
      }
      endLineStr.write(_separator);
    }
    _endLine = endLineStr.toString();
  }

  //仅Debug模式可见
  //防止数据过多打印不全问题
  static void d(dynamic obj) {
    if (_isDebug) {
      _log(obj.toString());
    }
  }
  //原始打印方法，
 static void print_org(dynamic obj) {
    if (_isDebug) {
      print(obj);
    }
  }

  static int _limit_line_Length = 800;
 //原始打印方法，
 static void print_more_line(dynamic obj) {
    if (_isDebug) {
      var msg=obj.toString();
      var size=msg.length;
      int each=(msg.length~/_limit_line_Length).ceil();
      for(int i=0;i<=each;i++){
        int end=(i+1)*_limit_line_Length;
        if(end>=size){
          end=size;
        }
        print(msg.substring(i*_limit_line_Length,end));
      }
    }
  }

  static void v(dynamic obj) {
    _log(obj.toString());
  }

  static void _log(String msg) {
    print("$_startLine");
    _logEmpyLine();
    if (msg.length < _limitLength) {
      print(msg);
    } else {
      segmentationLog(msg);
    }
    _logEmpyLine();
    print("$_endLine");
  }

  static void segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        print(outStr);
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
  }

  static void _logEmpyLine() {
    print("");
  }
//  ————————————————
//  版权声明：本文为CSDN博主「懒散的阿乐」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
//  原文链接：https://blog.csdn.net/zylvip/article/details/102608256
}
