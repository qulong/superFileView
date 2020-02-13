package com.silang.superfileview.dy;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.silang.superfileview.R;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


/**
 * @author: qulonglong
 * @date: 2019/12/12
 * @description please add a description here
 */
public class FlutterActDemo extends FlutterActivity {

    public static void show(Context context) {
        context.startActivity(new Intent(context, FlutterActDemo.class));
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.flutter_dd_view);
//        GeneratedPluginRegistrant.registerWith(this);
        initView();
    }


    protected void initView() {
        
    }

}
