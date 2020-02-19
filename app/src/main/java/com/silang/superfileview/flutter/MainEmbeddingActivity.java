package com.silang.superfileview.flutter;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.silang.superfileview.R;
import com.silang.superfileview.TLog;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author: qulonglong
 * @date: 2020/2/17
 * @description please add a description here
 */
public class MainEmbeddingActivity extends FlutterActivity {
    TextView valueTv;
    MethodChannel methodChannel;
    MethodChannel methodChanne2;

    private final String channel_engine_id_1 = "my_engine_id";
    private final String channel_engine_id_2 = "th_eng_id";

    public static void show(Context context) {
        context.startActivity(new Intent(context, MainEmbeddingActivity.class));
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//       FlutterView view= Flutter.createView(this,getLifecycle(),"th");
        setContentView(R.layout.embedding_layout);
        Button button = findViewById(R.id.btn_1);
        valueTv = findViewById(R.id.value_1);
//        GeneratedPluginRegistrant.registerWith(getFlutterEngine());
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startFlutter(channel_engine_id_1);
            }
        });
        valueTv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                initMethodChannel2();
                startFlutter(channel_engine_id_2);
            }
        });
        Button button1=findViewById(R.id.btn_2);
        button1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startFlutterAct("th");
            }
        });
    }

    void initMethodChannel2() {
        if (methodChanne2 != null) {
            return;
        }
        FlutterEngine flutterEngine = new FlutterEngine(MainEmbeddingActivity.this);
        flutterEngine.getNavigationChannel().setInitialRoute("chan2");
        flutterEngine.getDartExecutor().executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault());
        FlutterEngineCache.getInstance().put(channel_engine_id_2, flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), "channel2");
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                // 解析参数，做页面跳转
//                if ("openNative".equals(call.method)){
//                    TLog.e("MainEmbeddingActivity",call.arguments.toString());
//                }
                switch (methodCall.method) {
                    case "send2"://返回的方法名
                        //给flutter端的返回值
                        result.success("MethodChannelPlugin收到：这个是Android 给flutter的响应传递过去的值");
                        TLog.e("MainEmbeddingActivity", methodCall.arguments.toString());
                        valueTv.setText(methodCall.arguments.toString());
//                        if (activity instanceof FlutterAppActivity) {
//                            ((FlutterAppActivity) activity).showContent(methodCall.arguments);
//                        }
                        break;
                        case "loadData"://返回的方法名
                        //给flutter端的返回值
                        result.success("loadData flutter的响应传递过去的值loadData");
                        TLog.e("MainEmbeddingActivity", methodCall.arguments.toString());
                        valueTv.setText(methodCall.arguments.toString());
                        break;
                    default:
                        result.notImplemented();
                        break;
                }
            }
        });
    }

    //
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

//                flutterEngine = new FlutterEngine(this);
        flutterEngine.getNavigationChannel().setInitialRoute("methodcallBack");
//        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
//
//        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
                .getInstance()
                .put(channel_engine_id_1, flutterEngine);

        super.configureFlutterEngine(flutterEngine);
        TLog.e("MainEmbeddingActivity", "configureFlutterEngine configureFlutterEngine configureFlutterEngine");

//        MyPlugin.registerWith(flutterEngine.getDartExecutor());
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), "gogogo");
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                // 解析参数，做页面跳转
//                if ("openNative".equals(call.method)){
//                    TLog.e("MainEmbeddingActivity",call.arguments.toString());
//                }
                switch (methodCall.method) {
                    case "send"://返回的方法名
                        //给flutter端的返回值
                        result.success("MethodChannelPlugin收到：这个是Android 给flutter的响应传递过去的值");
                        TLog.e("MainEmbeddingActivity", methodCall.arguments.toString());
                        valueTv.setText(methodCall.arguments.toString());
//                        if (activity instanceof FlutterAppActivity) {
//                            ((FlutterAppActivity) activity).showContent(methodCall.arguments);
//                        }
                        break;
                    default:
                        result.notImplemented();
                        break;
                }
            }
        });
        TLog.e("getCachedEngineId()", "id=" + getCachedEngineId());
    }

    @Override
    public void cleanUpFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);
        FlutterEngineCache
                .getInstance()
                .remove(channel_engine_id_1);
        FlutterEngineCache
                .getInstance()
                .remove(channel_engine_id_2);

    }

    private void startFlutter(String engine_id) {

//        Intent customFlutter =FlutterActivity.withNewEngine()
//                .initialRoute(channel)
//                .build(this);
//        startActivity(customFlutter);

        Intent customFlutter = FlutterActivity.withCachedEngine(engine_id)
                .build(this);
        startActivity(customFlutter);
    }
    private void startFlutterAct(String channelName) {

        Intent customFlutter =FlutterActivity.withNewEngine()
                .initialRoute(channelName)
                .build(this);
        startActivity(customFlutter);
    }

    private void startFlutterDef() {
        Intent customFlutter = createDefaultIntent(this);
        startActivity(customFlutter);
    }

    //调用flutter端方法，无返回值
    public void invokeMethod(String method, Object o) {
        methodChannel.invokeMethod(method, o);
    }

    //调用flutter端方法，有返回值
    public void invokeMethod(String method, Object o, MethodChannel.Result result) {
        methodChannel.invokeMethod(method, o, result);
    }

}
