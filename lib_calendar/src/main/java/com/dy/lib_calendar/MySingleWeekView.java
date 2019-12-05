/*
 * Copyright (C) 2016 huanghaibin_dev <huanghaibin_dev@163.com>
 * WebSite https://github.com/MiracleTimes-Dev
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dy.lib_calendar;

import android.content.Context;
import android.graphics.Canvas;
import android.view.View;

/**
 * 修改自WeekView  自定义单选view
 */
public abstract class MySingleWeekView extends BaseWeekView {

    public MySingleWeekView(Context context) {
        super(context);
    }

    /**
     * 绘制日历文本
     *
     * @param canvas canvas
     */
    @Override
    protected void onDraw(Canvas canvas) {
        if (mItems.size() == 0)
            return;
        mItemWidth = (getWidth() - 2 * mDelegate.getCalendarPadding()) / 7;
        onPreviewHook();

        for (int i = 0; i < mItems.size(); i++) {
            int x = i * mItemWidth + mDelegate.getCalendarPadding();
            onLoopStart(x);
            Calendar calendar = mItems.get(i);
            boolean isSelected = i == mCurrentItem;
            boolean hasScheme = calendar.hasScheme();
            boolean isPreSelected = isPreWorkCalendar(calendar);
            boolean isNextSelected = isNextWorkCalendar(calendar);
            if (hasScheme) {
                    //将画笔设置为标记颜色
//                    mSchemePaint.setColor(calendar.getSchemeColor() != 0 ?
//                            calendar.getSchemeColor() : mDelegate.getSchemeThemeColor());
                    mSchemePaint.setColor(mDelegate.getSchemeThemeColor());
                    onDrawScheme(canvas, calendar, x,true,isPreSelected,isNextSelected);
                if (isSelected) {
                    onDrawSelected(canvas, calendar, x, true);
                }
            } else {
                if (isSelected) {
                    onDrawSelected(canvas, calendar, x, false);
                }
            }
            onDrawText(canvas, calendar, x, hasScheme, isSelected);
        }
    }

    @Override
    public void onClick(View v) {
        if (!isClick) {
            return;
        }
        Calendar calendar = getIndex();
        if (calendar == null) {
            return;
        }
        if (onCalendarIntercept(calendar)) {
            mDelegate.mCalendarInterceptListener.onCalendarInterceptClick(calendar, true);
            return;
        }
        if (!isInRange(calendar)) {
            if (mDelegate.mCalendarSelectListener != null) {
                mDelegate.mCalendarSelectListener.onCalendarOutOfRange(calendar);
            }
            return;
        }

        mCurrentItem = mItems.indexOf(calendar);

        if (mDelegate.mInnerListener != null) {
            mDelegate.mInnerListener.onWeekDateSelected(calendar, true);
        }
        if (mParentLayout != null) {
            int i = CalendarUtil.getWeekFromDayInMonth(calendar, mDelegate.getWeekStart());
            mParentLayout.updateSelectWeek(i);
        }

        if (mDelegate.mCalendarSelectListener != null) {
            mDelegate.mCalendarSelectListener.onCalendarSelect(calendar, true);
        }

        invalidate();
    }


    @Override
    public boolean onLongClick(View v) {
        if (mDelegate.mCalendarLongClickListener == null)
            return false;
        if (!isClick) {
            return false;
        }
        Calendar calendar = getIndex();
        if (calendar == null) {
            return false;
        }
        if (onCalendarIntercept(calendar)) {
            mDelegate.mCalendarInterceptListener.onCalendarInterceptClick(calendar, true);
            return true;
        }
        boolean isCalendarInRange = isInRange(calendar);

        if (!isCalendarInRange) {
            if (mDelegate.mCalendarLongClickListener != null) {
                mDelegate.mCalendarLongClickListener.onCalendarLongClickOutOfRange(calendar);
            }
            return true;
        }

        if (mDelegate.isPreventLongPressedSelected()) {//如果启用拦截长按事件不选择日期
            if (mDelegate.mCalendarLongClickListener != null) {
                mDelegate.mCalendarLongClickListener.onCalendarLongClick(calendar);
            }
            return true;
        }


        mCurrentItem = mItems.indexOf(calendar);

        mDelegate.mIndexCalendar = mDelegate.mSelectedCalendar;

        if (mDelegate.mInnerListener != null) {
            mDelegate.mInnerListener.onWeekDateSelected(calendar, true);
        }
        if (mParentLayout != null) {
            int i = CalendarUtil.getWeekFromDayInMonth(calendar, mDelegate.getWeekStart());
            mParentLayout.updateSelectWeek(i);
        }

        if (mDelegate.mCalendarSelectListener != null) {
            mDelegate.mCalendarSelectListener.onCalendarSelect(calendar, true);
        }

        if (mDelegate.mCalendarLongClickListener != null) {
            mDelegate.mCalendarLongClickListener.onCalendarLongClick(calendar);
        }

        invalidate();
        return true;
    }
    /**
     * 上一个日期是否选中
     *
     * @param calendar 当前日期
     * @return 上一个日期是否选中
     */

    protected final boolean isPreWorkCalendar(Calendar calendar) {
        Calendar preCalendar = CalendarUtil.getPreCalendar(calendar);
        mDelegate.updateCalendarScheme(preCalendar);
        return preCalendar.hasScheme();
    }

    /**
     * 下一个日期是否选中
     *
     * @param calendar 当前日期
     * @return 下一个日期是否选中
     */
    protected final boolean isNextWorkCalendar(Calendar calendar) {
        Calendar nextCalendar = CalendarUtil.getNextCalendar(calendar);
        mDelegate.updateCalendarScheme(nextCalendar);
        return nextCalendar.hasScheme();
    }
    /**
     * 绘制选中的日期
     *
     * @param canvas    canvas
     * @param calendar  日历日历calendar
     * @param x         日历Card x起点坐标
     * @param hasScheme hasScheme 非标记的日期
     * @return 是否绘制 onDrawScheme
     */
    protected abstract boolean onDrawSelected(Canvas canvas, Calendar calendar, int x, boolean hasScheme);

    /**
     * 绘制标记的日期
     *
     * @param canvas   canvas
     * @param calendar 日历calendar
     * @param x        日历Card x起点坐标
     */
    protected abstract void onDrawScheme(Canvas canvas, Calendar calendar, int x, boolean hasScheme,boolean isSelectedPre, boolean isSelectedNext);


    /**
     * 绘制日历文本
     *
     * @param canvas     canvas
     * @param calendar   日历calendar
     * @param x          日历Card x起点坐标
     * @param hasScheme  是否是标记的日期
     * @param isSelected 是否选中
     */
    protected abstract void onDrawText(Canvas canvas, Calendar calendar, int x, boolean hasScheme, boolean isSelected);
}
