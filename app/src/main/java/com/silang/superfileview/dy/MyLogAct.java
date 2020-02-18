package com.silang.superfileview.dy;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.design.widget.AppBarLayout;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.CoordinatorLayout;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.text.TextUtils;

import com.google.gson.Gson;
import com.silang.superfileview.R;
import com.silang.superfileview.TLog;
import com.silang.superfileview.calendar.mutl.base.activity.BaseActivity;
import com.silang.superfileview.dy.bean.FlutterParam;

import java.util.ArrayList;
import java.util.Map;

/**
 * @author: qulonglong
 * @date: 2019/12/12
 * @description please add a description here
 */
public class MyLogAct extends BaseActivity {

    AppBarLayout appBarLayout;
    CollapsingToolbarLayout collapsingToolbarLayout;
    TabLayout tableLayout;
    ViewPager viewPager;
    FragmentAdapter fAdapter;
    private ArrayList<Fragment> list;

    public static void show(Context context) {
        context.startActivity(new Intent(context, MyLogAct.class));
    }

    public static void showFlutter(Context context, String json) {
        Intent intent = new Intent(context, MyLogAct.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.putExtra("FlutterParam", json);
        context.startActivity(intent);
    }

    @Override
    protected int getLayoutId() {
        return R.layout.my_log_details;
    }

    @Override
    protected void initView() {
        appBarLayout = findViewById(R.id.appbar);
        collapsingToolbarLayout = findViewById(R.id.collapsingToolbar);
        tableLayout = findViewById(R.id.log_tab_layout);
        viewPager = findViewById(R.id.log_view_pager);
        String flutterJson = getIntent().getStringExtra("FlutterParam");
        if (!TextUtils.isEmpty(flutterJson)) {
            Gson gson = new Gson();
            FlutterParam flutterV = gson.fromJson(flutterJson, FlutterParam.class);
            TLog.e("flutter", flutterV.value);
        }
//        CoordinatorLayout.LayoutParams params = (CoordinatorLayout.LayoutParams) appBarLayout.getLayoutParams();
//        AppBarLayout.Behavior behavior = (AppBarLayout.Behavior) params.getBehavior();
//        behavior.setDragCallback(new AppBarLayout.Behavior.BaseDragCallback() {
//            @Override
//            public boolean canDrag(@NonNull AppBarLayout appBarLayout) {
//                return true;
//            }
//        });
        appBarLayout.addOnOffsetChangedListener(new AppBarStateChangeListener() {
            @Override
            public void onStateChanged(AppBarLayout appBarLayout, int state) {
                if (state == State.EXPANDED) {
                    State.BoxerUserAppBarShow = true;
                    //展开状态
                } else if (state == State.COLLAPSED) {
                    State.BoxerUserAppBarShow = false;
                    //折叠状态
                } else {
                    State.BoxerUserAppBarShow = false;
                    //中间状态
                }
            }
        });
        tableLayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                LogDetailsTitleItem item = (LogDetailsTitleItem) tab.getCustomView();
                if (item != null) {
                    item.setClick(true);
                }
                viewPager.setCurrentItem(tab.getPosition());
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {
                LogDetailsTitleItem item = (LogDetailsTitleItem) tab.getCustomView();
                if (item != null) {
                    item.setClick(false);
                }
            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });

    }

    @Override
    protected void initData() {
        ArrayList<String> title = new ArrayList<>();
        title.add("动态1");
        title.add("动态2");
        title.add("动态3");
        list = new ArrayList<>();
        list.add(Fragment1.getFragment("动态1"));
        list.add(Fragment1.getFragment("动态2"));
        list.add(Fragment1.getFragment("动态3"));
        fAdapter = new FragmentAdapter(getSupportFragmentManager(), list);
        viewPager.setAdapter(fAdapter);
        viewPager.setOffscreenPageLimit(list.size());
        tableLayout.setupWithViewPager(viewPager);
        for (int i = 0; i < fAdapter.getCount(); i++) {
            TabLayout.Tab tab = tableLayout.getTabAt(i);//获得每一个tab
            if (tab != null) {
                tab.setCustomView(new LogDetailsTitleItem(MyLogAct.this));//给每一个tab设置view
                LogDetailsTitleItem item = (LogDetailsTitleItem) tab.getCustomView();
                if (item != null) {
                    item.setTitle(title.get(i));
                    if (i == 0) {
                        item.setClick(true);
                    } else {
                        item.setClick(false);
                    }
                }
            }
        }
    }
//————————————————
//    版权声明：本文为CSDN博主「梦想从未放弃」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
//    原文链接：https://blog.csdn.net/u011225387/article/details/95588335
}
