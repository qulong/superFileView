import 'package:flutter/material.dart';
import 'package:my_flutter/utils/ColorUtils.dart';

import 'BaseTitleBar.dart';
import 'BaseViewBar.dart';
import 'ChannelAllActivity.dart';
///
/// 无效订单 待处理 已处理筛选
///
class FilterActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FilterView();
  }
}

class FilterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilterState();
  }
}

//获取文字样式
_titleTextStyle({double size = 14, Color cr = ColorUtils.c333333_60}) {
  return TextStyle(fontSize: size, color: cr);
}

class FilterState extends State<FilterView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      print('input ${controller.text}');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseViewBar(
        childView: BaseTitleBar(
          "筛选",
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0.0,
              child: Container(
                padding: EdgeInsets.only(left: 14, right: 14),
                width: MediaQuery.of(context).size.width,
                child: Scrollbar(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Row(children: <Widget>[
                          Text(
                            "来源渠道",
                            style: _titleTextStyle(),
                          ),
                          FlatButton(child: Row(
                            children: <Widget>[
                              Text(
                                "全部",
                                style: TextStyle(
                                    color: ColorUtils.c333333_30, fontSize: 14),
                              ),
                              Padding(
                                child: Image.asset(
                                  'images/gray_arrow.png',
                                  width: 8,
                                  height: 12,
                                ),
                                padding: EdgeInsets.only(left: 5),
                              ),
                            ],
                          ),onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (ct){
                              return ChannelAllActivity();
                            }));
                          },)
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "跟进人",
                              style: _titleTextStyle(),
                            ),
                            Expanded(
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.only(
                                  left: 12,
                                ),
                                child: TextField(
                                  controller: controller,
                                  style: _titleTextStyle(size: 14),
                                  decoration: InputDecoration(
                                    hintText: '请输入',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: ColorUtils.c444444_30),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: ColorUtils.c444444),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                      _flexView(),
                      _flexView(),
                      _flexView(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 25,bottom: 12),child: Text('获取方式',
                              style: TextStyle(fontSize: 14, color: ColorUtils.c333333_60)),),
                          Row(children: <Widget>[
                            SizedBox(
                              width: 150,
                              height: 30,
                              child: FlatButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: ColorUtils.cF4F4F4,
                                child: Text(
                                  '开始日期',
                                  style:
                                  TextStyle(fontSize: 14, color: ColorUtils.c444444_30),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 12,right: 12),child: Text('至',style: _titleTextStyle(cr: ColorUtils.c444444),),),
                            SizedBox(
                              width: 150,
                              height: 30,
                              child: FlatButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: ColorUtils.cF4F4F4,
                                child: Text(
                                  '结束日期',
                                  style:
                                  TextStyle(fontSize: 14, color: ColorUtils.c444444_30),
                                ),
                              ),
                            ),

                          ],)
                        ],
                      ),


                    ],
                  ),
                )),
              )),
          Positioned(
            bottom: 18.0,
            left: 1,
            right: 1,
            child: Row(children: <Widget>[
              SizedBox(
                width: 160,
                height: 40,
                child: FlatButton(
                  onPressed: (){_itemInnerClick(false);},
                  child: Text(
                    "拒绝",
                    style: _titleTextStyle(cr: ColorUtils.c444444_60),
                  ),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: ColorUtils.c444444)),
                ),
              ),
              SizedBox(
                width: 160,
                height: 40,
                child: FlatButton(
                  onPressed: (){_itemInnerClick(true);},
                  child: Text(
                    "同意",
                    style:  _titleTextStyle(cr: ColorUtils.c444444),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: ColorUtils.cE4B974,
                ),
              ),
            ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          ),
        ],
      ),
    );
  }
  _itemInnerClick(bool ok){
    print(ok);
  }
  _flexView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 25,bottom: 12),child: Text('是是是',
              style: TextStyle(fontSize: 14, color: ColorUtils.c333333_60)),),
          Wrap(
            spacing: 20.0, // 主轴(水平)方向间距
            runSpacing: 10.0, // 纵轴（垂直）方向间距
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: ColorUtils.cF4F4F4,
                  child: Text(
                    '重要',
                    style:
                        TextStyle(fontSize: 12, color: ColorUtils.c333333_30),
                  ),
                ),
              ), SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: ColorUtils.cF4F4F4,
                  child: Text(
                    '重要',
                    style:
                        TextStyle(fontSize: 12, color: ColorUtils.c333333_30),
                  ),
                ),
              ), SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: ColorUtils.cF4F4F4,
                  child: Text(
                    '重要',
                    style:
                        TextStyle(fontSize: 12, color: ColorUtils.c333333_30),
                  ),
                ),
              ), SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: ColorUtils.cF4F4F4,
                  child: Text(
                    '重要',
                    style:
                        TextStyle(fontSize: 12, color: ColorUtils.c333333_30),
                  ),
                ),
              ), SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: ColorUtils.cF4F4F4,
                  child: Text(
                    '重要',
                    style:
                        TextStyle(fontSize: 12, color: ColorUtils.c333333_30),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
