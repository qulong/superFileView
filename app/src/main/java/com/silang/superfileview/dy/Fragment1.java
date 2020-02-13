package com.silang.superfileview.dy;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.silang.superfileview.R;
import com.silang.superfileview.calendar.car.CarList;
import com.silang.superfileview.calendar.car.RecCarAdapter;

/**
 * @author: qulonglong
 * @date: 2019/12/12
 * @description please add a description here
 */
public class Fragment1 extends Fragment {
    private TextView tt;
private RecyclerView recyclerView;

    public static Fragment1 getFragment(String tt) {
        Fragment1 starFragment = new Fragment1();
        Bundle bundle = new Bundle();
        bundle.putString("UserId", tt);
        starFragment.setArguments(bundle);
        return starFragment;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        String tes = getArguments().getString("UserId");
        tt = getView().findViewById(R.id.rage_1);

        recyclerView=getView().findViewById(R.id.recView);
        RecCarAdapter adapter=new RecCarAdapter(getActivity());
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        recyclerView.setAdapter(adapter);
        adapter.addDatas(CarList.getCars1());
        tt.setText(tes);
    }


    @Override
    public void onStart() {
        super.onStart();

    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.frag_1, null);
        return view;
    }
}
