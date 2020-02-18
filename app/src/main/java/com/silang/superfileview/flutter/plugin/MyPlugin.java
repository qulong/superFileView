package com.silang.superfileview.flutter.plugin;

import com.silang.superfileview.App;
import com.silang.superfileview.TLog;
import com.silang.superfileview.dy.MyLogAct;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author: qulonglong
 * @date: 2020/2/13
 * @description please add a description here
 */
public class MyPlugin {
    public static void registerWith(final BinaryMessenger messenger){
        new MethodChannel(messenger, "com.your.packagename/flutter_plugin").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                TLog.e("openNativeopenNativeopenNativeopenNative");
                // 解析参数，做页面跳转
                if ("openNative".equals(methodCall.method)){
                    schemePage(methodCall,result);
                }
            }
        });
    }

    public static void schemePage(MethodCall methodCall, MethodChannel.Result result) {

        String target = methodCall.argument("target");
       String json= methodCall.argument("params");
//       TLog.e("params",json.toString());
//       TLog.e("params param1",json.get("param1").toString());
        switch (target) {
            case FlutterConstant.ROUTE_NATIVE_SETTING:
                MyLogAct.showFlutter(App.getContext(),json);
                break;
            default:
                break;
        }
    }
//
//    作者：孑孓
//    链接：https://juejin.im/post/5c7a26faf265da2da8358eb1
//    来源：掘金
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
}
