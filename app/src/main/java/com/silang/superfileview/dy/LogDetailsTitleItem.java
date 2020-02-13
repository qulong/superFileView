package com.silang.superfileview.dy;

import android.content.Context;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;


import com.silang.superfileview.R;
import com.silang.superfileview.dy.baseview.BaseFrameLayout;
import com.silang.superfileview.dy.baseview.InjectView;

import static android.view.View.INVISIBLE;
import static android.view.View.VISIBLE;

/**
 * Created by qulonglong
 * on 2018/5/2.
 */

public class LogDetailsTitleItem extends BaseFrameLayout {
    @InjectView(id = R.id.order_title_layout_name)
    TextView title;
    @InjectView(id = R.id.order_title_layout_line)
    View line;

    public LogDetailsTitleItem(Context context) {
        this(context, null);
    }

    public LogDetailsTitleItem(Context context, AttributeSet attrs) {
        super(context, attrs);
        mContentView = LayoutInflater.from(context).inflate(R.layout.find_title_layout, this, true);
        autoInjectAllFields(mContentView);
    }

    public void setTitle(String title) {
        this.title.setText(title);
    }

    public void setClick(boolean click) {
        if (click) {
//            title.setTextColor(getResources().getColor(R.color.white));
            title.setTextSize(TypedValue.COMPLEX_UNIT_SP, 30);
            line.setVisibility(VISIBLE);
        } else {
//            title.setTextColor(getResources().getColor(R.color.c8989A1));
            title.setTextSize(TypedValue.COMPLEX_UNIT_SP, 20);
            line.setVisibility(INVISIBLE);
        }
    }
}
