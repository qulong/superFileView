import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
//
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClueActivity extends StatelessWidget {
  ClueActivity();

  @override
  Widget build(BuildContext context) {
    return ClueView();
  }
}

class ClueView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateClue();
  }
}

class StateClue extends State<ClueView> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
//        header: WaterDropHeader(),
//        footer: CustomFooter(
//          builder: (BuildContext context, LoadStatus mode) {
//            Widget body;
//            if (mode == LoadStatus.idle) {
//              body = Text("上拉加载");
//            } else if (mode == LoadStatus.loading) {
//              body = CupertinoActivityIndicator();
//            } else if (mode == LoadStatus.failed) {
//              body = Text("加载失败！点击重试！");
//            } else if (mode == LoadStatus.canLoading) {
//              body = Text("松手,加载更多!");
//            } else {
//              body = Text("没有更多数据了!");
//            }
//            return Container(
//              height: 55.0,
//              child: Center(child: body),
//            );
//          },
//        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,

        child: ListView.separated(itemBuilder: (c, i) => Container(child: Column(children: <Widget>[
            Row(children: <Widget>[
              Row(children: <Widget>[
                Text("标题 $i" ,style: TextStyle(color: Colors.black,fontSize: 18),),
              Icon(Icons.pie_chart),],),
              Container(child: Text("待审核",style: TextStyle(fontSize: 16,backgroundColor: Colors.blueGrey,color: Colors.red),),)
            ],mainAxisAlignment: MainAxisAlignment.spaceBetween),
            Text("申请人q：$i" ,style: TextStyle(color: Colors.black54,fontSize: 16),),
            Text("申请人a：$i" ,style: TextStyle(color: Colors.black54,fontSize: 16, height: 2.0),),
            Text("申请人s：$i" ,style: TextStyle(color: Colors.black54,fontSize: 16, height: 2.0),),
            Container(child: Text("申请人t：$i" ,style: TextStyle(color: Colors.black54,fontSize: 16),),margin: EdgeInsets.only(top: 12,bottom: 12),)

          ],crossAxisAlignment: CrossAxisAlignment.start,),padding: EdgeInsets.all(12),),
          separatorBuilder: (c,i){
          if(i>0) {
            return Divider(height: 2.0, color: Colors.deepPurpleAccent);
          }else{
            return Container();
          }
},
        itemCount: items.length)
      )
    );
  }
}
