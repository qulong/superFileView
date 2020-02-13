package com.silang.superfileview.calendar.popupwindow;

import android.animation.Animator;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.silang.superfileview.R;
import com.silang.superfileview.ratingstar.RatingStarView;

import razerdp.basepopup.BasePopupWindow;

/**
 * @author: qulonglong
 * @date: 2019/12/11
 * @description 编辑和删除弹框
 */
public class PopupDeleteEidt extends BasePopupWindow {
    private TextView delete, edit;
    private DeleteAndEidtImpl deleteAndEidt;

    public PopupDeleteEidt(Context context) {
        super(context);
        delete = findViewById(R.id.popup_delete);
        edit = findViewById(R.id.popup_edit);
        delete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (deleteAndEidt != null) {
                    deleteAndEidt.delete();
                }
            }
        });
        edit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (deleteAndEidt != null) {
                    deleteAndEidt.edit();
                }
            }
        });
    }

    public void setDeleteAndEidt(DeleteAndEidtImpl impl) {
        deleteAndEidt = impl;
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

    public interface DeleteAndEidtImpl {
        void delete();

        void edit();
    }

    @Override
    public View onCreateContentView() {
        return createPopupById(R.layout.popopwindow_delete_edit);
    }
}
