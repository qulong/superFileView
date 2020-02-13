package com.silang.superfileview;

import android.content.Context;
import android.content.res.TypedArray;
import android.support.annotation.DrawableRes;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * toolbar 自定义
 */
public class MyToolbarView extends FrameLayout {
    ImageView backImg, shareImg;
    TextView title, right;

    private int titleColor, rightTvColor, backImgId, shareImgId;
    private String titleStr, rightStr;
    private boolean shareVisible, rightTvVisible;

    public MyToolbarView(Context context) {
        this(context, null);
    }

    public MyToolbarView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public MyToolbarView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        TypedArray array = context.obtainStyledAttributes(attrs, R.styleable.MyToolbarView);
        View view = LayoutInflater.from(context).inflate(R.layout.toolbar_view_layout, this, true);

        titleColor = array.getColor(R.styleable.MyToolbarView_toolbar_title_color, 0xFF333333);
        rightTvColor = array.getColor(R.styleable.MyToolbarView_toolbar_right_tv_color, 0xFF333333);
        titleStr = array.getString(R.styleable.MyToolbarView_toolbar_title_tv);
        rightStr = array.getString(R.styleable.MyToolbarView_toolbar_right_tv);
        backImgId = array.getResourceId(R.styleable.MyToolbarView_toolbar_back_img, R.mipmap.back);
//       backImgId= array.getResourceId(R.styleable.MyToolbarView_toolbar_share_img,R.mipmap.sh);
        shareVisible = array.getBoolean(R.styleable.MyToolbarView_toolbar_share_visible, false);
        rightTvVisible = array.getBoolean(R.styleable.MyToolbarView_toolbar_right_visibility, false);
        array.recycle();
        initview(view);
    }

    private void initview(View view) {
        backImg = (ImageView) view.findViewById(R.id.toolbar_img_back);
        shareImg = (ImageView) view.findViewById(R.id.toolbar_img_share);
        title = (TextView) view.findViewById(R.id.toolbar_title_tv);
        right = (TextView) view.findViewById(R.id.toolbar_right_tv);
        backImg.setImageResource(backImgId);
        title.setText(titleStr);
        if (shareVisible){
            shareImg.setVisibility(VISIBLE);
            shareImg.setImageResource(shareImgId);
        }else {
            shareImg.setVisibility(GONE);
        }
        if (rightTvVisible) {
            right.setVisibility(VISIBLE);
            right.setText(rightStr);
        }else {
            right.setVisibility(GONE);
        }
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
