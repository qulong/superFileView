package com.silang.superfileview.dy;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import java.util.List;

/**
 * @author: qulonglong
 * @date: 2019/12/12
 * @description please add a description here
 */
public class FragmentAdapter  extends FragmentPagerAdapter {
    //    private String [] title = {"one","two","three","four","five","six"};
    private List<Fragment> fragmentList;
    public FragmentAdapter(FragmentManager fm, List<Fragment> fragmentList) {
        super(fm);
        this.fragmentList = fragmentList;
    }
    @Override
    public Fragment getItem(int position) {
        return fragmentList.get(position);
    }
    @Override
    public int getCount() {
        return fragmentList.size();
    }
//    @Override
//    public CharSequence getPageTitle(int position) {
//        return title[position];
//    }
}
