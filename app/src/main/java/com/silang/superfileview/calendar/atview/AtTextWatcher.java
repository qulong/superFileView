package com.silang.superfileview.calendar.atview;

import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.widget.EditText;

/**
 * @author: qulonglong
 * @date: 2019/12/5
 * @description please add a description here
 */
public class AtTextWatcher implements TextWatcher {
private final String TAG="AtTextWatcher";
    char atEndFlag = (char) 8197;
    AtListener mListener;
    private int atIndex = -1;
    private int endFlagIndex = -1;
    public AtTextWatcher(AtListener listener) {
        this.mListener = listener;
    }

    public void insertTextForAt(EditText et, CharSequence text){
        if(atIndex == -1)
            return;
        StringBuilder sb = new StringBuilder(text);
        sb.append(atEndFlag);
        text = sb.toString();
        Editable text1 = et.getText();
        text1.insert(atIndex+1, text);
//        et.invalidate();
    }

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        if(count == 1){//删除一个字符
            char c = s.charAt(start);
            if(c == atEndFlag){
                endFlagIndex = start;
            }
        }
    }

    /**
     * @param s 新文本内容，即文本改变之后的内容
     * @param start 被修改文本的起始偏移量
     * @param before 被替换旧文本长度
     * @param count 替换的新文本长度
     */
    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {
        if(count == 1){//新增(输入)一个字符
            char c = s.charAt(start);
            if(c == '@'){
                atIndex = start;
                if(mListener != null){
                    mListener.triggerAt();
                }
            }
        }
    }

    @Override
    public void afterTextChanged(Editable s) {
        Log.i(TAG, "afterTextChanged() called with: s = [" + s + "]");
        if(endFlagIndex != -1){
            int index = endFlagIndex;
            while ((index -= 1) != -1){
                char c = s.charAt(index);
                if(c == '@'){
                    break;
                }
            }
            int endFlagIndex = this.endFlagIndex;
            this.endFlagIndex = -1;
            if(index != -1)
                s.delete(index, endFlagIndex);
        }
    }

    /**
     * 输入 @ 监听
     */
    public interface AtListener{
        void triggerAt();
    }
//    原文链接：https://blog.csdn.net/qq_27070117/article/details/89105007

//    使用
    //final EditText et = mEt;
    //final AtTextWatcher atTextWatcher;
    //AtTextWatcher.AtListener listener = new AtTextWatcher.AtListener() {
    //           @Override
    //           public void triggerAt() {
    //               // 此处跳转好友列表
    //			// 选择完好友后执行下面的方法
    //			atTextWatcher.insertTextForAt(et, "张三")
    //           }
    //       };
    //atTextWatcher = new AtTextWatcher(listener);
    //et.addTextChangedListener(atTextWatcher);
}
