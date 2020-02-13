package com.silang.superfileview.calendar.popupwindow;

import android.content.Context;
import android.content.Intent;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;

import com.silang.superfileview.R;
import com.silang.superfileview.calendar.mutl.base.activity.BaseActivity;

/**
 * @author: qulonglong
 * @date: 2019/12/11
 * @description please add a description here
 */
public class PopupWindowAct extends BaseActivity {
    TextView v1, v2;

    public static void show(Context context) {
        context.startActivity(new Intent(context, PopupWindowAct.class));
    }

    @Override
    protected int getLayoutId() {
        return R.layout.popupwind_llyout;
    }

    @Override
    protected void initView() {
        v1 = findViewById(R.id.view_1);
    }

    @Override
    protected void initData() {
        v1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ScorePopup popup = new ScorePopup(PopupWindowAct.this);
                popup.setOutSideDismiss(false);
                popup.setOutSideTouchable(false);
                popup.setPopupGravity(Gravity.BOTTOM);
                popup.showPopupWindow();
            }
        });
    }
}
