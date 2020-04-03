import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/eventbus/TabViewChangeEvent.dart';
import 'package:my_flutter/utils/ColorUtils.dart';
import 'package:my_flutter/utils/MyLog.dart';
import 'package:my_flutter/xiansuo/BaseViewBar.dart';
import 'package:event_bus/event_bus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ClueTitleBar.dart';
import 'FilterActivity.dart';

class TabClue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewChild();
  }
}

class ViewChild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateViewChild();
  }
}

class StateViewChild extends State<ViewChild>
    with SingleTickerProviderStateMixin {
  List<String> titleList = ['待处理', '已处理'];

  TabController _tabController;
  String defSelected = '待处理';
  int defIndex = 0;
  EventBus _eventBus = EventBus();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyLog.init(title: 'tabview');

    _tabController = TabController(vsync: this, length: titleList.length);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        setState(() {
          defIndex = _tabController.index;
          defSelected = titleList[_tabController.index];
        });
        print("滑动tabview");
        MyLog.d(this.defSelected.toString() + this.defIndex.toString());
        _eventBus.fire(TabViewChangeEvent(
            titleList[_tabController.index], _tabController.index));
      }
    });
  }

  _selectedCallBack(title, index) {
    if (this.defIndex != index) {
      _tabController.index = index;
      setState(() {
        defIndex = index;
        defSelected = title;
      });
    }
  }

  _rightIconClick(int type) {
    MyLog.print_org("点击右边按钮" + type.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return FilterActivity();
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: new DefaultTabController(
        length: titleList.length,
        child: new Scaffold(
          appBar: BaseViewBar(
              childView: ClueTitleBar(_selectedCallBack,
                  rightClick: _rightIconClick,
                  centerTabTitle: this.titleList,
                  defSelect: this.defSelected,
                  eventBus: this._eventBus)),
          body: new TabBarView(
            controller: _tabController,
            children: titleList.map((choice) {
              return new ClueView(choice);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ClueView extends StatefulWidget {
  String choice;

  ClueView(this.choice);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateClue(this.choice);
  }
}

///无效审核===待处理==已处理
class StateClue extends State<ClueView> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Color colorCxt = const Color.fromRGBO(51, 51, 51, 0.4);
  String type; //待处理 已处理

  StateClue(this.type);

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
        backgroundColor: Colors.white,
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
//              body = Text("上拉加载");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败！点击重试！");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松手,加载更多!");
                } else {
                  body = Text("没有更多数据了!");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.separated(
                itemBuilder: (c, i) => _getWidgetListItem(i),
                separatorBuilder: (c, i) {
                  return Container(height: 10, color: Color(0xFFF9F9F9));
                },
                itemCount: items.length)));
  }

  _getWidgetListItem(int i) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "标题 $i",
                    style: TextStyle(
                        color: Color.fromRGBO(68, 68, 68, 1), fontSize: 14),
                  ),
                  Padding(
                    child: Image.asset(
                      'images/list_v_light.png',
                      width: 20,
                      height: 20,
                    ),
                    padding: EdgeInsets.only(left: 10),
                  ),
                ],
              ),
              Container(
                child: Text(
                  "待审核",
                  style: TextStyle(fontSize: 9, color: Color(0xFFE4B974)),
                ),
                color: Color.fromRGBO(228, 185, 116, 0.41),
                padding: EdgeInsets.only(left: 6, right: 6),
              )
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
            Text(
              "申请人：$i",
              style: TextStyle(color: colorCxt, fontSize: 12, height: 2.0),
            ),
            Text(
              "理由：$i",
              style: TextStyle(color: colorCxt, fontSize: 12, height: 2.0),
            ),
            Text(
              "备注：$i",
              style: TextStyle(color: colorCxt, fontSize: 12, height: 2.0),
            ),
            _bottomBtn(),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.all(12),
      ),
      onTap: (){_itemClick();},
    );
  }
 _itemClick(){
    MyLog.print_org("item 被点击");
}

 _itemInnerClick(bool ok){
    if(ok){
      MyLog.print_org("同意 被点击");
    }else{
      MyLog.print_org("拒绝 被点击");
    }

}
  /// 区分待处理和已处理
  _bottomBtn() {
    if (this.type == '待处理') {
      return Row(children: <Widget>[
        SizedBox(
          width: 142,
          height: 32,
          child: FlatButton(
            onPressed: (){_itemInnerClick(false);},
            child: Text(
              "拒绝",
              style: TextStyle(fontSize: 14, color: ColorUtils.c333333_60),
            ),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: ColorUtils.c333333_20)),
          ),
        ),
        SizedBox(
          width: 142,
          height: 32,
          child: FlatButton(
            onPressed: (){_itemInnerClick(true);},
            child: Text(
              "同意",
              style: TextStyle(fontSize: 14, color: ColorUtils.cE4B974),
            ),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(color: ColorUtils.cECB768)),
          ),
        ),
      ], mainAxisAlignment: MainAxisAlignment.spaceEvenly);
    } else {
      return Container();
    }
  }
}
