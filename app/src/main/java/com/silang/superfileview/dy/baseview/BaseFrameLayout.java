package com.silang.superfileview.dy.baseview;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import java.lang.reflect.Field;

/**
 * 支持自定义View注解
 */
public class BaseFrameLayout extends FrameLayout {

    protected View mContentView;

    public BaseFrameLayout(Context context) {
        this(context, null);
    }

    public BaseFrameLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    protected void autoInjectAllFields() {
        autoInjectAllFields(mContentView);
    }

    protected void autoInjectAllFields(View contentView) {
        Class clazz=this.getClass();
        Field[]fields=clazz.getDeclaredFields();
        for(Field field :fields) {
            if(field.isAnnotationPresent(InjectView.class)) {
                InjectView inject=field.getAnnotation(InjectView.class);
                int id=inject.id();
                if(id > 0) {
                    //反射访问私有成员，必须加上这句
                    field.setAccessible(true);
                    try {//IllegalAccessException IllegalArgumentException
                        field.set(this, contentView.findViewById(id));
                    } catch (Exception e) {
                        Log.d("tuotian", "autoInjectAllFields failed; " + e);
                    }
                }
            }
        }
    }

}
