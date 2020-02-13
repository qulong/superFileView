package com.silang.superfileview;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.res.AssetFileDescriptor;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListPopupWindow;
import android.widget.TextView;

import com.silang.superfileview.R;
import com.silang.superfileview.calendar.atview.ATviewAct;
import com.silang.superfileview.calendar.mutl.MultiActivity;
import com.silang.superfileview.calendar.popupwindow.PopupWindowAct;
import com.silang.superfileview.calendar.single.SingleActivity;
import com.silang.superfileview.dy.MyLogAct;
import com.silang.superfileview.flutter.MainFlutterActivity;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.android.FlutterView;
import pub.devrel.easypermissions.EasyPermissions;

public class MainActivity extends AppCompatActivity {

    RecyclerView mRecyclerView;
    private String filePath;
    private List<String> datas = new ArrayList<>();
    private ListPopupWindow mListPop;
    private ArrayList<String> lists = new ArrayList<>();

    @SuppressLint("ResourceAsColor")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initDatas();
        initPaths();
        MyToolbarView myToolbarView = (MyToolbarView) findViewById(R.id.toolbar_ttt);
        myToolbarView.setBackgroundColor(R.color.colorPrimaryDark);
        myToolbarView.title.setText("哈哈哈哈");
        mListPop = new ListPopupWindow(this);
        lists.add("one");
        lists.add("two");
        lists.add("three");
        mListPop.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, lists));
        mListPop.setWidth(ViewGroup.LayoutParams.WRAP_CONTENT);
        mListPop.setHeight(ViewGroup.LayoutParams.WRAP_CONTENT);
        mListPop.setAnchorView(myToolbarView);//设置ListPopupWindow的锚点，即关联PopupWindow的显示位置和这个锚点
        mListPop.setModal(true);//设置是否是模式
        mListPop.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {
                myToolbarView.title.setText(lists.get(position));
                mListPop.dismiss();

            }
        });

        myToolbarView.title.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mListPop.show();
            }
        });
        myToolbarView.backImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        mRecyclerView = (RecyclerView) findViewById(R.id.mRecyclerView);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        mRecyclerView.setAdapter(new RecyclerView.Adapter() {
            @Override
            public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

                return new RecyclerView.ViewHolder(LayoutInflater.from(MainActivity.this).inflate(R.layout.item, parent, false)) {
                };

            }

            @Override
            public void onBindViewHolder(RecyclerView.ViewHolder holder, final int position) {
                holder.itemView.findViewById(R.id.item_root).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if ("calendar".equals(datas.get(position))) {
                            MultiActivity.show(MainActivity.this);
                        } else if ("SingleActivity".equals(datas.get(position))) {
                            SingleActivity.show(MainActivity.this);
                        }  else if ("atatat演示".equals(datas.get(position))) {
                            ATviewAct.startAt(MainActivity.this);
                        }  else if ("popup演示".equals(datas.get(position))) {
                            PopupWindowAct.show(MainActivity.this);
                        }   else if ("mylog".equals(datas.get(position))) {
//                            MyLogAct.show(MainActivity.this);
                            MainFlutterActivity.show(MainActivity.this);
                        } else {
                            String[] perms = new String[]{Manifest.permission.READ_EXTERNAL_STORAGE,
                                    Manifest.permission.WRITE_EXTERNAL_STORAGE};
                            filePath = getFilePath(position);
                            if (!EasyPermissions.hasPermissions(MainActivity.this, perms)) {
                                EasyPermissions.requestPermissions(MainActivity.this, "需要访问手机存储权限！", 10086, perms);
                            } else {
                                FileDisplayActivity.show(MainActivity.this, filePath);
                            }
                        }

                    }
                });
                ((TextView) holder.itemView.findViewById(R.id.item_tv)).setText(getDatas().get(position));
            }

            @Override
            public int getItemCount() {
                return getDatas().size();
            }
        });
    }

    private void initPaths() {
    }

    private void initDatas() {
        datas.add("网络获取并打开doc文件");
        datas.add("打开本地doc文件");


        datas.add("打开本地txt文件");

        datas.add("打开本地excel文件");


        datas.add("打开本地ppt文件");


        datas.add("打开本地pdf文件");
        datas.add("calendar");
        datas.add("SingleActivity");
        datas.add("atatat演示");
        datas.add("popup演示");
        datas.add("mylog");
    }

    private List<String> getDatas() {

        if (datas != null && datas.size() > 0) {
            return datas;
        } else {
            datas = new ArrayList<>();
            initDatas();
            return datas;
        }

    }

    private String getFilePath(int position) {
        String path = null;
        switch (position) {
            case 0:
                path = "https://file.saas.dyrs.com.cn/group1/M00/00/3B/fwAAAV3o34mADMeMAAcoY-Eyqv0411.pdf";
//                path = "https://file.saas.dyrs.com.cn/group1/M00/00/52/fwAAAV4KtPiAYemRAADEij5i8Y0290.pdf";
//                path = "http://www.hrssgz.gov.cn/bgxz/sydwrybgxz/201101/P020110110748901718161.doc";
                break;
            case 1:

                path = "/storage/emulated/0/test/test.docx";

                break;


            case 2:
                path = "/storage/emulated/0/test/test.txt";
                break;

            case 3:
                path = "/storage/emulated/0/test/test.xlsx";
                break;
            case 4:
                path = "/storage/emulated/0/test/test.pptx";
                break;

            case 5:
                path = "/storage/emulated/0/test/test.pdf";
                break;
        }
        return path;
    }
}
