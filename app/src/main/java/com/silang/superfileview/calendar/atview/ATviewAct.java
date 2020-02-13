package com.silang.superfileview.calendar.atview;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.silang.superfileview.R;

import java.util.List;

/**
 * @author: qulonglong
 * @date: 2019/12/5
 * @description please add a description here
 */
public class ATviewAct extends AppCompatActivity {
    EditText editText;
    MsgEditText msgEditText;
    AtTextWatcher atTextWatcher;
    MentionEditText mentionEditText;
    Button btn;
    public static void startAt(Context context){
        Intent intent=new Intent(context,ATviewAct.class);
        context.startActivity(intent);
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_at);
         editText=findViewById(R.id.at_edit);
        msgEditText=findViewById(R.id.at_msgend);
        mentionEditText=findViewById(R.id.at_mevsgend);
         btn=findViewById(R.id.at_btn);

        AtTextWatcher.AtListener listener = new AtTextWatcher.AtListener() {
                   @Override
                   public void triggerAt() {
                       // 此处跳转好友列表
                       // 选择完好友后执行下面的方法
                       atTextWatcher.insertTextForAt(editText, "张三");
                   }
               };
        atTextWatcher = new AtTextWatcher(listener);
        editText.addTextChangedListener(atTextWatcher);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                atTextWatcher.insertTextForAt(editText, "张三");
                msgEditText.addAtSpan("@","李四","ksksk");
                mentionEditText.getText().append("@ksdfjksl @叫你发多少 ");
            }
        });

        List<String> mentionList = mentionEditText.getMentionList(true); //get a list of mention string
        mentionEditText.setMentionTextColor(Color.RED); //optional, set highlight color of mention string
        mentionEditText.setPattern("@","@[\\u4e00-\\u9fa5\\w\\-]+"); //optional, set regularExpression
        mentionEditText.setOnMentionInputListener(new MentionEditText.OnMentionInputListener() {
            @Override
            public void onMentionCharacterInput(String tag) {

            }
        });
    }

}
