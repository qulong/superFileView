package com.dy.lib_calendar;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.view.View;


/**
 * @author: qulonglong
 * @date: 2019/12/4
 * @description 月份  重写
 */
public abstract class MyMonthView extends BaseMonthView {

    public MyMonthView(Context context) {
        super(context);
    }


    @Override
    protected void onDraw(Canvas canvas) {
        if (mLineCount == 0)
            return;
        mItemWidth = (getWidth() - 2 * mDelegate.getCalendarPadding()) / 7;
        onPreviewHook();
        int count = mLineCount * 7;
        int d = 0;
        for (int i = 0; i < mLineCount; i++) {
            for (int j = 0; j < 7; j++) {
                Calendar calendar = mItems.get(d);
                if (mDelegate.getMonthViewShowMode() == CalendarViewDelegate.MODE_ONLY_CURRENT_MONTH) {
                    if (d > mItems.size() - mNextDiff) {
                        return;
                    }
                    if (!calendar.isCurrentMonth()) {
                        ++d;
                        continue;
                    }
                } else if (mDelegate.getMonthViewShowMode() == CalendarViewDelegate.MODE_FIT_MONTH) {
                    if (d >= count) {
                        return;
                    }
                }
                draw(canvas, calendar, i, j);
                ++d;
            }
        }
    }

    /**
     * 开始绘制
     *
     * @param canvas   canvas
     * @param calendar 对应日历
     * @param i        i
     * @param j        j
     */
    private void draw(Canvas canvas, Calendar calendar, int i, int j) {
        int x = j * mItemWidth + mDelegate.getCalendarPadding();
        int y = i * mItemHeight;
        onLoopStart(x, y);
        boolean isSelected = isCalendarSelected(calendar);
        boolean hasScheme = calendar.hasScheme();
        boolean isPreSelected = isPreWorkCalendar(calendar);
        boolean isNextSelected = isNextWorkCalendar(calendar);

        if (hasScheme) {
            //标记的日子
            boolean isDrawSelected = false;//是否继续绘制选中的onDrawScheme
            if (isSelected) {
                isDrawSelected =onDrawScheme(canvas, calendar, x, y, true, isPreSelected, isNextSelected);
            }
            if (isDrawSelected || !isSelected) {
                //将画笔设置为标记颜色
                mSchemePaint.setColor(calendar.getSchemeColor() != 0 ? calendar.getSchemeColor() : mDelegate.getSchemeThemeColor());
                onDrawSelected(canvas, calendar, x, y, true);
            }

        } else {
            if (isSelected) {
                onDrawSelected(canvas, calendar, x, y, true);
            }
        }
        onDrawText(canvas, calendar, x, y, hasScheme, isSelected);
    }

    /**
     * 日历是否被选中
     *
     * @param calendar calendar
     * @return 日历是否被选中
     */
    protected boolean isCalendarSelected(Calendar calendar) {
        return !onCalendarIntercept(calendar) && mDelegate.mSelectedCalendars.containsKey(calendar.toString());
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

        if (mDelegate.getMonthViewShowMode() == CalendarViewDelegate.MODE_ONLY_CURRENT_MONTH
                && !calendar.isCurrentMonth()) {
            return;
        }

        if (onCalendarIntercept(calendar)) {
            mDelegate.mCalendarInterceptListener.onCalendarInterceptClick(calendar, true);
            return;
        }

        if (!isInRange(calendar)) {
            if (mDelegate.mCalendarMultiSelectListener != null) {
                mDelegate.mCalendarMultiSelectListener.onCalendarMultiSelectOutOfRange(calendar);
            }
            return;
        }

        String key = calendar.toString();

        if (mDelegate.mSelectedCalendars.containsKey(key)) {
            mDelegate.mSelectedCalendars.remove(key);
        } else {
            if (mDelegate.mSelectedCalendars.size() >= mDelegate.getMaxMultiSelectSize()) {
                if (mDelegate.mCalendarMultiSelectListener != null) {
                    mDelegate.mCalendarMultiSelectListener.onMultiSelectOutOfSize(calendar,
                            mDelegate.getMaxMultiSelectSize());
                }
                return;
            }
            mDelegate.mSelectedCalendars.put(key, calendar);
        }

        mCurrentItem = mItems.indexOf(calendar);

        if (!calendar.isCurrentMonth() && mMonthViewPager != null) {
            int cur = mMonthViewPager.getCurrentItem();
            int position = mCurrentItem < 7 ? cur - 1 : cur + 1;
            mMonthViewPager.setCurrentItem(position);
        }

        if (mDelegate.mInnerListener != null) {
            mDelegate.mInnerListener.onMonthDateSelected(calendar, true);
        }

        if (mParentLayout != null) {
            if (calendar.isCurrentMonth()) {
                mParentLayout.updateSelectPosition(mItems.indexOf(calendar));
            } else {
                mParentLayout.updateSelectWeek(CalendarUtil.getWeekFromDayInMonth(calendar, mDelegate.getWeekStart()));
            }
        }
        if (mDelegate.mCalendarMultiSelectListener != null) {
            mDelegate.mCalendarMultiSelectListener.onCalendarMultiSelect(
                    calendar,
                    mDelegate.mSelectedCalendars.size(),
                    mDelegate.getMaxMultiSelectSize());
        }
    }

    @Override
    public boolean onLongClick(View v) {
        return false;
    }

    /**
     * 上一个日期是否选中
     *
     * @param calendar 当前日期
     * @return 上一个日期是否选中
     */
    protected final boolean isSelectPreCalendar(Calendar calendar) {
        Calendar preCalendar = CalendarUtil.getPreCalendar(calendar);
        mDelegate.updateCalendarScheme(preCalendar);
        return isCalendarSelected(preCalendar);
    }

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
    protected final boolean isSelectNextCalendar(Calendar calendar) {
        Calendar nextCalendar = CalendarUtil.getNextCalendar(calendar);
        mDelegate.updateCalendarScheme(nextCalendar);
        return isCalendarSelected(nextCalendar);
    }
    protected final boolean isNextWorkCalendar(Calendar calendar) {
        Calendar nextCalendar = CalendarUtil.getNextCalendar(calendar);
        mDelegate.updateCalendarScheme(nextCalendar);
        return nextCalendar.hasScheme();
    }
    /**
     * 绘制选中的日期
     *
     * @param canvas         canvas
     * @param calendar       日历日历calendar
     * @param x              日历Card x起点坐标
     * @param y              日历Card y起点坐标
     * @param hasScheme      hasScheme 非标记的日期
     * @param isSelectedPre  上一个日期是否选中
     * @param isSelectedNext 下一个日期是否选中
     * @return 是否继续绘制onDrawScheme，true or false
     */
    protected abstract boolean onDrawScheme(Canvas canvas, Calendar calendar, int x, int y, boolean hasScheme,
                                              boolean isSelectedPre, boolean isSelectedNext);

    /**
     * 绘制标记的日期,这里可以是背景色，标记色什么的
     *
     * @param canvas     canvas
     * @param calendar   日历calendar
     * @param x          日历Card x起点坐标
     * @param y          日历Card y起点坐标
     * @param isSelected 是否选中
     */
    protected abstract void onDrawSelected(Canvas canvas, Calendar calendar, int x, int y, boolean isSelected);


    /**
     * 绘制日历文本
     *
     * @param canvas     canvas
     * @param calendar   日历calendar
     * @param x          日历Card x起点坐标
     * @param y          日历Card y起点坐标
     * @param hasScheme  是否是标记的日期
     * @param isSelected 是否选中
     */
    protected abstract void onDrawText(Canvas canvas, Calendar calendar, int x, int y, boolean hasScheme, boolean isSelected);
}