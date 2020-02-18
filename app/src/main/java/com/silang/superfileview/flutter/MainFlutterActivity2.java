package com.silang.superfileview.flutter;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import com.silang.superfileview.flutter.plugin.FlutterPluginCounter;
import com.silang.superfileview.flutter.plugin.FlutterPluginJumpToAct;
import com.silang.superfileview.flutter.plugin.MyPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.facade.Flutter;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;


/**
 * @author: qulonglong
 * @date: 2020/2/11
 * @description please add a description here
 * 这个可以跳转到flutter的默认页面
 * <p>
 * 传参 https://www.jianshu.com/p/c5263a3d7aac
 */
public class MainFlutterActivity2 extends FlutterActivity {

    public static void show(Context context) {
        context.startActivity(new Intent(context, MainFlutterActivity2.class));
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.my_flutter_act2);

//        FrameLayout frameLayout = findViewById(R.id.framelayout);
        FlutterView flutterView = getFlutterView();
        flutterView.setInitialRoute("seconds");
//        final FlutterRunArguments arguments = new FlutterRunArguments();
//        arguments.bundlePath = FlutterMain.findAppBundlePath();
//        arguments.entrypoint = "main";
//        flutterView.runFromBundle(arguments);

        setContentView(flutterView);
//        GeneratedPluginRegistrant.registerWith(flutterView.getPluginRegistry());
//        registerCustomPlugin(this);
        MyPlugin.registerWith(flutterView);
//        frameLayout.addView(flutterView)

    }

    private static void registerCustomPlugin(PluginRegistry registrar) {

        FlutterPluginJumpToAct.registerWith(registrar.registrarFor(FlutterPluginJumpToAct.CHANNEL));

        FlutterPluginCounter.registerWith(registrar.registrarFor(FlutterPluginCounter.CHANNEL));
    }


}
