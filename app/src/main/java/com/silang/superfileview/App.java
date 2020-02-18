package com.silang.superfileview;

/**
 * Created by 12457 on 2017/8/2.
 */

import android.annotation.SuppressLint;
import android.app.Application;
import android.content.Context;
import android.os.Build;

import com.tencent.smtt.sdk.QbSdk;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
//import io.flutter.view.FlutterMain;

/**
 * Created by ljh
 * on 2016/12/22.
 */
public class App extends Application {

    @SuppressLint("StaticFieldLeak")
    private static Context context;

//    private FlutterEngine flutterEngine;
    @Override
    public void onCreate() {
        super.onCreate();
        context = getApplicationContext();
        //增加这句话
        QbSdk.initX5Environment(this, null);
        ExceptionHandler.getInstance().initConfig(this);


        // Instantiate a FlutterEngine.
//        flutterEngine = new FlutterEngine(this);
//
//        // Start executing Dart code to pre-warm the FlutterEngine.
//        flutterEngine.getDartExecutor().executeDartEntrypoint(
//                DartExecutor.DartEntrypoint.createDefault()
//        );
//
//        // Cache the FlutterEngine to be used by FlutterActivity.
//        FlutterEngineCache
//                .getInstance()
//                .put("my_engine_id", flutterEngine);

//        FlutterMain.startInitialization(this);
    }

    public static Context getContext() {
        return context;
    }

}
