package com.silang.superfileview.calendar.car;

/**
 * @author: qulonglong
 * @date: 2019/12/11
 * @description please add a description here
 */
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import com.silang.superfileview.R;
import com.silang.superfileview.calendar.single.NormalDecoration;

import java.util.List;

public class LinearNormalActivity extends AppCompatActivity {

    RecyclerView mRecyclerView;
    ImageView ivAvatar;
    private int color=R.color.colorAccent;
    public static void show(Context context) {
        context.startActivity(new Intent(context, LinearNormalActivity.class));
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_layout);
        mRecyclerView=findViewById(R.id.recView);
        final List<Car> carList = CarList.getCars();

        final RecCarAdapter adapter = new RecCarAdapter(this);
        adapter.addDatas(carList);


        final NormalDecoration decoration = new NormalDecoration() {
            @Override
            public String getHeaderName(int pos) {
                return "AAA";
            }
        };
        View headView = LayoutInflater.from(LinearNormalActivity.this).inflate(R.layout.decoration_car_head_view, null);
        ivAvatar = (ImageView) headView.findViewById(R.id.header_iv_avatar);
        decoration.setOnHeaderClickListener(new NormalDecoration.OnHeaderClickListener() {
            @Override
            public void headerClick(int pos) {
                if (color==R.color.line_color) {
                    color = R.color.colorAccent;
                }else {
                    color=R.color.line_color;
                }
//                headView.invalidate();
                mRecyclerView.scrollBy(0,1);
                Toast.makeText(LinearNormalActivity.this, "点击到头部" + carList.get(pos).getHeaderName(), Toast.LENGTH_SHORT).show();
            }
        });
decoration.setOnDecorationHeadDraw(new NormalDecoration.OnDecorationHeadDraw() {
    @Override
    public View getHeaderView(int pos) {
//        decoration.loadImage(carList.get(pos).getLetter(), pos, ivAvatar);
        Log.e("QDX", "view inflate " + pos + "头部" + headView.hashCode());
        ivAvatar.setImageResource(color);
        decoration.setTextColor(color);
        headView.invalidate();
        return headView;
    }
});

        LinearLayoutManager manager = new LinearLayoutManager(this);
        mRecyclerView.addItemDecoration(decoration);
        mRecyclerView.setLayoutManager(manager);
        mRecyclerView.setAdapter(adapter);
    }
}
