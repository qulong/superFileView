package com.silang.superfileview.calendar.popupwindow;

import android.animation.Animator;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.view.View;
import android.view.animation.OvershootInterpolator;
import android.widget.EditText;
import android.widget.ImageView;

import com.silang.superfileview.R;
import com.silang.superfileview.ratingstar.RatingStarView;

import razerdp.basepopup.BasePopupWindow;

/**
 * @author: qulonglong
 * @date: 2019/12/11
 * @description please add a description here
 */
public class ScorePopup extends BasePopupWindow {
    private ImageView close;
    private RatingStarView star1, star2, star3;
    private EditText editText;

    public ScorePopup(Context context) {
        super(context);
    }

    @Override
    protected Animator onCreateShowAnimator() {
        return createAnimator(true);
    }

    @Override
    protected Animator onCreateDismissAnimator() {
        return createAnimator(false);
    }

    private Animator createAnimator(boolean isShow) {
        ObjectAnimator showAnimator = ObjectAnimator.ofFloat(getDisplayAnimateView(),
                View.TRANSLATION_Y,
                isShow ? getHeight() : 0,
                isShow ? 0 : getHeight());
        showAnimator.setDuration(300);
//        showAnimator.setInterpolator(new OvershootInterpolator(isShow ? 6 : -6));
        return showAnimator;

    }

    @Override
    public View onCreateContentView() {
        return createPopupById(R.layout.score_popopwindow);
    }
}
