import 'package:flutter/material.dart';
class Counter with ChangeNotifier{
  int value = 0;
  increment(){
    value ++;
    //发送通知
    print(value);
    notifyListeners();
  }
}