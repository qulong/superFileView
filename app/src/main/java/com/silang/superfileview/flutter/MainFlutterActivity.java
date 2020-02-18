//package com.silang.superfileview.flutter;
//
//import android.content.Context;
//import android.content.Intent;
//import android.os.Bundle;
//import android.view.View;
//import android.widget.FrameLayout;
//import android.widget.TextView;
//
//import com.silang.superfileview.R;
//import com.silang.superfileview.flutter.plugin.FlutterPluginCounter;
//import com.silang.superfileview.flutter.plugin.FlutterPluginJumpToAct;
//import com.silang.superfileview.flutter.plugin.MyPlugin;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.android.FlutterView;
//import io.flutter.plugin.common.PluginRegistry;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//
//
///**
// * @author: qulonglong
// * @date: 2020/2/11
// * @description please add a description here
// * 这个可以跳转到flutter的默认页面
// */
//public class MainFlutterActivity extends FlutterActivity{
//
//    public static void show(Context context) {
//        context.startActivity(new Intent(context, MainFlutterActivity.class));
//    }
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//
//        setContentView(R.layout.my_flutter_act);
////        GeneratedPluginRegistrant.registerWith(this.getFlutterEngine());
//
////        实例化 FlutterView 嵌入 Native
////        FlutterView flutterView = new FlutterView(this);
////        FrameLayout frameLayout = findViewById(R.id.framelayout);
////        frameLayout.addView(flutterView);
//////创建一个 FlutterView 就可以了，这个时候还不会渲染。
//////调用下面代码后才会渲染
////        flutterView.attachToFlutterEngine(this.getFlutterEngine());
//
////        作者：连续三届村草
////        链接：https://juejin.im/post/5dc90f9a6fb9a04a7a05dc1e
////        来源：掘金
////        著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
////
////        registerCustomPlugin(this.);
//
//        TextView tt = findViewById(R.id.jump_1);
//        tt.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                startFlutterDef();
////                startFlutter("th");
////                startFlutter("seconds");
//            }
//        });
//    }
//
//    private static void registerCustomPlugin(PluginRegistry registrar) {
//
//        FlutterPluginJumpToAct.registerWith(registrar.registrarFor(FlutterPluginJumpToAct.CHANNEL));
//
//        FlutterPluginCounter.registerWith(registrar.registrarFor(FlutterPluginCounter.CHANNEL));
//    }
//
//    private void startFlutter(String channel) {
//        Intent customFlutter = FlutterActivity.withNewEngine()
//                .initialRoute(channel)
//                .build(this);
//        startActivity(customFlutter);
//    }
//
//    private void startFlutterDef() {
//        Intent customFlutter = FlutterActivity.createDefaultIntent(this);
//        startActivity(customFlutter);
//    }
//
//}
