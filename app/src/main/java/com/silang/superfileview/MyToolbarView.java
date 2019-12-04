package com.silang.superfileview;

import android.content.Context;
import android.support.annotation.DrawableRes;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
/**
 * toolbar 自定义
 * */
public class MyToolbarView extends FrameLayout {
    ImageView backImg, shareImg;
    TextView title, right;

    public MyToolbarView(Context context) {
        this(context, null);
    }

    public MyToolbarView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public MyToolbarView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        View view = LayoutInflater.from(context).inflate(R.layout.toolbar_view_layout, this, true);
        initview(view);
    }

    private void initview(View view) {
        backImg = (ImageView) view.findViewById(R.id.toolbar_img_back);
        shareImg = (ImageView) view.findViewById(R.id.toolbar_img_share);
        title = (TextView) view.findViewById(R.id.toolbar_title_tv);
        right = (TextView) view.findViewById(R.id.toolbar_right_tv);
    }

    public ImageView getBackImg() {
        return backImg;
    }

    public void setBackImgRes(@DrawableRes int resid) {
        this.backImg.setBackgroundResource(resid);
    }

    public void setShareImgRes(@DrawableRes int resid) {
        this.shareImg.setBackgroundResource(resid);
    }

    public ImageView getShareImg() {
        return shareImg;
    }


    public TextView getRightTv() {
        return right;
    }

    public void setTitleStr(String title) {
        this.title.setText(title);
    }
}
