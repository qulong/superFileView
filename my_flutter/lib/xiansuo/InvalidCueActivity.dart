import 'package:flutter/material.dart';
import 'package:my_flutter/dialog/MessageDialog.dart';
import 'package:my_flutter/dialog/TextFiledDialog.dart';
import 'package:my_flutter/utils/ColorUtils.dart';

import 'BaseTitleBar.dart';
import 'BaseViewBar.dart';

class InvalidCueActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InvalidCueView();
  }
}

class InvalidCueView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InvalidCueState();
  }
}

class InvalidCueState extends State<InvalidCueView> {
  Map<int, List<String>> dataMap = new Map();
  PageController _pageController = new PageController();
  int pageIndex = 0;
  int pageSize = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataMap[0] = ["a", 'b', 'c', 'c', 'c'];
    dataMap[1] = ["a", 'b', 'c'];
    dataMap[2] = ["a", 'b', 'c'];
    dataMap[3] = ["a", 'b'];
    setState(() {
      pageSize = dataMap.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseViewBar(
          childView: BaseTitleBar("无效线索",rightIconUrl: 'images/right_search.png',rightClick: (){
            print("点击搜索");
          },),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _initPageView()),

            ///底部按钮
            Container(
              height: 70,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(children: <Widget>[
                SizedBox(
                  width: 60,
                  height: 30,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "${pageIndex + 1}/${pageSize}",
                      style:
                          TextStyle(fontSize: 12, color: ColorUtils.c333333_60),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: ColorUtils.cEBEBEB,
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 30,
                  child: FlatButton(
                    onPressed: () {
//                      _pageController.jumpToPage(3);
                      show();
                    },
                    child: Text(
                      "跳转",
                      style: TextStyle(fontSize: 14, color: ColorUtils.c444444),
                    ),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: ColorUtils.c444444)),
                  ),
                ),
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
          ],
        ));
  }

  /// PageView 控件
  _initPageView() {
    var carList = <Widget>[];
    dataMap.forEach((key, value) {
      carList.add(_itemPageViewCard(value));
    });
    var page = PageView.builder(
      itemBuilder: (context, index) {
        return _itemPageViewCard(dataMap[index]);
      },
      itemCount: dataMap.length,
      controller: _pageController,
      onPageChanged: (index) {
        print('======第===${index.toString()}===页=============');
//        setState(() {
//          pageIndex = index;
//        });
      },
    );
    return page;
//    return PageView(
//      children: carList,
//      controller: _pageController,
//      onPageChanged: (index){
//        print('======第===${index.toString()}===页=============');
//        setState(() {
//          pageIndex=index;
//        });
//      },
//    );
  }
show(){
  showDialog<String>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TextFiledDialog(onCloseEvent:(){
          Navigator.of(context).pop('ddd');
        },);
      });
}
  ///每一个卡片
  _itemPageViewCard(List<String> value) {
    var carList = <Widget>[];
    var size = value.length;
    for (int i = 0; i < size; i++) {
      carList.add(_itemView());
      if (i < size - 1) {
        carList.add(_itemLineView());
      }
    }
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: carList,
        ),
      ),
      margin: EdgeInsets.all(15),
    );
  }

  ///单个itemView
  Widget _itemView() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "珠江帝景家园",
            style:
                TextStyle(fontSize: 14, color: ColorUtils.c333333, height: 2.0),
          ),
          Row(
            children: <Widget>[
              Text(
                "单国勋",
                style: TextStyle(
                    fontSize: 12, color: ColorUtils.c333333, height: 2.0),
              ),
              Text(
                "   |  ",
                style: TextStyle(
                    fontSize: 12, color: ColorUtils.c333333_60, height: 2.0),
              ),
              Text(
                "SJ193545365478",
                style: TextStyle(
                    fontSize: 12, color: ColorUtils.c333333, height: 2.0),
              ),
            ],
          ),
          Text(
            "百度 / 网站推广 / 2019-03-11",
            style: TextStyle(
                fontSize: 12, color: ColorUtils.c333333_60, height: 2.0),
          ),
          Text(
            "无效原因：竞品竞品竞品竞品竞品竞品竞品",
            style: TextStyle(
                fontSize: 12, color: ColorUtils.c333333_60, height: 2.0),
          ),
          Text(
            "销售进程：DIM方案报价",
            style: TextStyle(
                fontSize: 12, color: ColorUtils.c333333_60, height: 2.0),
          ),
          Text(
            "最后跟进人：王大拿",
            style: TextStyle(
                fontSize: 12, color: ColorUtils.c333333_60, height: 2.0),
          ),
        ],
      ),
    );
  }

  /// 分割线
  _itemLineView() {
    return Container(
      height: 1,
      color: ColorUtils.lineColor,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(top: 5, bottom: 5),
    );
  }
}
