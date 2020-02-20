import 'dart:isolate';

import 'package:device_info/device_info.dart';
import 'dart:io';

import '../dyrs/beans/UserInfoConstant.dart';

class DeviceInfoUtils {
  static void ininDeviceInfo() {
    getDeviceInfo();
  }

  static void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (Platform.isIOS) {
      print('IOS设备：');
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo);
    } else if (Platform.isAndroid) {
      print('Android设备');
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//      print(await asyncFibonacci(3));
      print(androidInfo.board);
      print(androidInfo.device);
      print(androidInfo.id);
      print(androidInfo.androidId);
//      signal: aimei865166010224213
//      e0d55e0216e16444
//      userCode: User1906180379
      UserInfoConstant.DeviceId=androidInfo.androidId;
    }
  }

//这里以计算斐波那契数列为例，返回的值是Future，因为是异步的
  static Future<dynamic> asyncFibonacci(int i) async {
    final response = new ReceivePort();
    await Isolate.spawn(isolateTask, response.sendPort);
    final sendPort = await response.first as SendPort;
    final answer = new ReceivePort();
    sendPort.send([i, answer.sendPort]);
    return answer.first;
  }

//创建isolate必须要的参数
  static void isolateTask(SendPort initialReplyTo) {
    final port = new ReceivePort();
    //绑定
    initialReplyTo.send(port.sendPort);
    //监听
    port.listen((message) {
      //获取数据并解析
      final data = message[0] as int;
      final send = message[1] as SendPort;
      //返回结果
//      send.send(aa(data));
      send.send(aa());
    });
  }

  static int aa() {
    getDeviceInfo();
    return 1;
  }

// static int aa(int n){
//
//    return n < 2 ? n : aa(n-2) + aa(n-1);
//  }

}
