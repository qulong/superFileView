import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:my_flutter/azLlistview/az_common.dart';
import 'package:my_flutter/azLlistview/az_listview.dart';
import 'package:my_flutter/azLlistview/city_json.dart';
import 'package:my_flutter/utils/ColorUtils.dart';

import 'BaseTitleBar.dart';
import 'BaseViewBar.dart';

///
/// 无效订单筛选  全部渠道选择列表
///
class ChannelAllActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChannelView('哈哈');
  }
}

class CityInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;
  bool selected = false;
  CityInfo({this.name, this.tagIndex, this.namePinyin, this.selected = false});

  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension,
        'selected': selected
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" +" \"seleced\":\"" + selected.toString() + "\"" + '}';
//  name: "北京市", tagIndex: "热门"
}

class ChannelView extends StatefulWidget {
  final String title;

  ChannelView(this.title);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChannelState();
  }
}

class ChannelState extends State<ChannelView> {
  List<CityInfo> _cityList = List();
  List<CityInfo> _hotCityList = List();

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";
  @override
  void initState() {
    super.initState();
    _hotCityList.add(CityInfo(name: "北京市", tagIndex: "热门"));
    _hotCityList.add(CityInfo(name: "广州市", tagIndex: "热门"));
    _hotCityList.add(CityInfo(name: "成都市", tagIndex: "热门"));
    _hotCityList.add(CityInfo(name: "深圳市", tagIndex: "热门"));
    _hotCityList.add(CityInfo(name: "杭州市", tagIndex: "热门"));
    _hotCityList.add(CityInfo(name: "武汉市", tagIndex: "热门"));

    loadData();
  }

  void loadData() async {
    //加载城市列表
//  String jsonstr= CityJson.citylist.toString();
//  Map countyMap = await json.decode(jsonstr);
    List list = CityJson.citylist['china'];
    list.forEach((value) {
      _cityList.add(CityInfo(name: value['name']));
    });
    _handleList(_cityList);

    setState(() {
      _suspensionTag = _hotCityList[0].getSuspensionTag();
    });
  }

  ///org loaddata
//  void loadData() async {
//    //加载城市列表
//    rootBundle.loadString('assets/data/city_json.json').then((value) {
//      Map countyMap = json.decode(value);
//      List list = countyMap['china'];
//      list.forEach((value) {
//        _cityList.add(CityInfo(name: value['name']));
//      });
//      _handleList(_cityList);
//
//      setState(() {
//        _suspensionTag = _hotCityList[0].getSuspensionTag();
//      });
//    });
//  }
  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getFirstWordPinyin(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    list.sort((city1, city2) =>
        city1.getSuspensionTag().compareTo(city2.getSuspensionTag()));
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  ///构建悬停Widget.
  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xffffffff),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: ColorUtils.c333333,
        ),
      ),
    );
  }

  ///构建列表 item Widget.
  Widget _buildListItem(CityInfo model) {
    return Column(children: <Widget>[
      Offstage(
        offstage: !(model.isShowSuspension == true),
        child: _buildSusWidget(model.getSuspensionTag()),
      ),
      SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            contentPadding: EdgeInsets.only(right: 40, left: 15),
            title: Text(
              model.name,
              style:
                  TextStyle(fontSize: 14, color: colorStatue(model.selected)),
            ),
            onTap: () {
              print("OnItemClick: $model");
//              Navigator.pop(context, model);
              model.selected = !model.selected;
              setState(() {});
            },
            trailing: iconStatus(model.selected),
          )),
    ]);
  }

  Color colorStatue(bool ok) {
    if (ok) {
      return ColorUtils.cE4B974;
    } else {
      return ColorUtils.c333333;
    }
  }

  Widget iconStatus(bool ok) {
    if (ok) {
      return Image.asset('images/fillter_selected_3x.png',width: 18,height: 14,);
    } else {
      return Image.asset('');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseViewBar(
          childView: BaseTitleBar("全部"),
        ),
        body: new Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15.0),
              height: 50.0,
              child: Text("当前城市: 成都市"),
            ),
            Expanded(
                flex: 1,
                child: AzListView(
                  data: _cityList,
                  topData: _hotCityList,
                  itemBuilder: (context, model) => _buildListItem(model),
                  suspensionWidget: _buildSusWidget(_suspensionTag),
                  isUseRealIndex: true,
                  itemHeight: _itemHeight,
                  suspensionHeight: _suspensionHeight,
                  onSusTagChanged: _onSusTagChanged,
                )),
            Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 12),
              child: Row(children: <Widget>[
                SizedBox(
                  width: 160,
                  height: 40,
                  child: FlatButton(
                    onPressed: () {
                      _cityList.forEach((city){
                        city.selected=false;
                      });
                      setState(() {

                      });
                    },
                    child: Text(
                      "清空",
                      style:
                          TextStyle(fontSize: 14, color: ColorUtils.c444444_60),
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
                    onPressed: () {
                      _cityList.forEach((city){
                        if(city.selected){
                          print(city.toString());
                        }
                      });
                    },
                    child: Text(
                      "确定",
                      style: TextStyle(fontSize: 14, color: ColorUtils.c444444),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: ColorUtils.cE4B974,
                  ),
                ),
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
            )
          ],
        ));
  }
}
