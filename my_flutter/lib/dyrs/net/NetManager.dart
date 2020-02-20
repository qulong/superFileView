import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_flutter/dyrs/beans/UserInfoConstant.dart';
import 'package:my_flutter/utils/StringUtils.dart';

class NetManager {
  static final GET = 'get';
  static final POST = 'post';
  static final int TIMEOUT_CONNECT = 50000;
  static final int TIMEOUT_RECEIVE = 50000;
  static final int TIMEOUT_SEND = 50000;
  /**
   * get 请求
   */
  static getData(String url, Function successCallback,
      {Map<String, dynamic> params, Function errorCallBack}) async {
//    if (params != null && params.isNotEmpty) {
//      StringBuffer stringBuffer = new StringBuffer("?");
//      params.forEach((key, value) {
//        stringBuffer.write("$key" + "=" + "$value" + "&");
//      });
//      String paramStr = stringBuffer.toString();
//      paramStr = paramStr.substring(0, paramStr.length - 1);
//      url += paramStr;
//    }
    _request(url, successCallback,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  /**
   * Post请求
   */
  static postData(String url, Function successCallback,
      {Map<String, dynamic> params, Function errorCallBack}) async {
    _request(url, successCallback,
        method: POST, params: params, errorCallBack: errorCallBack);
  }

  static void _request(String url, Function successCallback,
      {String method,
      Map<String, dynamic> params,
      Function errorCallBack}) async {
    print("==========url=============");
    print("url = $url");
    String errorMsg = "";
    int statusCode;

    // if (!StringUtils.isEmptyNull(Datas.TOKEN)) {
//    headers.put("token", Datas.TOKEN);
//  }
//  headers.put("signal", Datas.DeviceId);
//  headers.put("userCode", Datas.USER_CODE);
//  headers.put("source", Datas.source);
    Map<String, dynamic> head = Map();
    if (StringUtils.isNotEmp(UserInfoConstant.TOKEN)) {
      head["token"] = UserInfoConstant.TOKEN;
    }
    if (StringUtils.isNotEmp(UserInfoConstant.DeviceId)) {
      head["signal"] = UserInfoConstant.DeviceId;
      params["signal"]=UserInfoConstant.DeviceId;
    }
    if (StringUtils.isNotEmp(UserInfoConstant.USER_CODE)) {
      head["userCode"] = UserInfoConstant.USER_CODE;
      params["userCode"]=UserInfoConstant.USER_CODE;
    }
    head["source"] = "android";
    try {
      Response response;
      BaseOptions baseOptions = new BaseOptions(
        connectTimeout: TIMEOUT_CONNECT,
        receiveTimeout: TIMEOUT_RECEIVE,
        contentType: 'application/json;charset=UTF-8',
        headers: head,
      );
      // dio库中默认将请求数据序列化为json，此处可根据后台情况自行修改
//      contentType:new ContentType('application', 'x-www-form-urlencoded',charset: 'utf-8')
      Options options = new Options(
        receiveTimeout: TIMEOUT_RECEIVE,
        sendTimeout: TIMEOUT_SEND,
      );

      print("==========param=============");
      print(params);
      print("==========header=============");
      print(head);
      print("==========baseOptions=============");
      print(baseOptions);
      print("==========options=============");
      print(options);
      Dio dio = new Dio(baseOptions);
      if (method == GET) {
        response =
            await dio.get(url, queryParameters: params, options: options);
      } else {
        response =
            await dio.post(url, queryParameters: params, options: options);
      }
      statusCode = response.statusCode;
      if (statusCode != HttpStatus.ok) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
      } else {
        if (successCallback != null) {
          print('================org data back===============');
          var data =response.data; //json.decode(response.toString()); //对数据进行Json转化
          print('================org response.data===============');
          print(data);
          successCallback(data);
        }
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  static _handError(Function function, String msg) {
    print('================err error===============');
    function(msg);
  }
}
