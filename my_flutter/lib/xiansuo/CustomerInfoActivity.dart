import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/dialog/NetLoadingDialog.dart';
import 'package:my_flutter/dyrs/net/UrlApi.dart';
import 'package:my_flutter/dyrs/beans/UserInfoConstant.dart';
import 'package:my_flutter/dyrs/net/NetManager.dart';
import 'package:my_flutter/utils/ColorUtils.dart';
import 'package:my_flutter/utils/ImageUtils.dart';
import 'package:my_flutter/utils/MyLog.dart';
import 'package:my_flutter/utils/StringUtils.dart';
import 'package:my_flutter/view/popwindow.dart';
import 'BaseTitleBar.dart';
import 'BaseViewBar.dart';

///客户资料
class CustomerInfoActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomerInfoView();
  }
}

class CustomerInfoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomerInfoState();
  }
}

class CustomerInfoState extends State<CustomerInfoView>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;
  GlobalKey globalKey;
  dynamic dataValue;
  bool noData=false;
  String address;
  @override
  void initState() {
    super.initState();
    globalKey = GlobalKey();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 6);
    MyLog.init(title: 'customerinfoview');
//    UserInfoConstant.TOKEN = 'ORMc4pJcc4cszYIvWc+NGQ==';
Future.delayed(Duration(milliseconds: 1),(){
  dialog();
});
  }
  dialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new NetLoadingDialog(
            loadingText:'加载中...',
            dismissCallback: _loadData,
            outsideDismiss: false,
          );
        });
  }
  /// 加载数据
   _loadData(Function popClose) {
    NetManager.postData(
        UrlApi.CustomerDetailsInfo,
        (data) {
          MyLog.d("call success back");
          setState(() {
            noData=StringUtils.isEmpty(data);
            dataValue = data;
          });
        },
        params: {"code": 'SJ2000000001'},
        errorCallBack: (errormsg) {
          MyLog.d(errormsg);
        },loadingClose: popClose);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BaseViewBar(
            childView: BaseTitleBar(
              "hhh",
              rightIconUrl: 'images/more_2x.png',
              rightClick: () {
                _popuMenu2();
              },
              centerView: CenterFullView(
                defTitle: '中间空间',
                clickCall: () {
                  print('点击中间控件');
//                  showPopupWindow(context: context,child: Container(child: Text('lskdjfas;ldkjflk;sadjf'),),fullWidth:true,isShowBg:true);
//                  showPopupView();
                  Navigator.push(
                    context,
                    PopRoute(
                      child: Popup(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  '测试1',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorUtils.c333333, fontSize: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '测试2',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorUtils.c333333, fontSize: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '测试3',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorUtils.c333333, fontSize: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '测试4',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorUtils.c333333, fontSize: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '测试4',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorUtils.c333333, fontSize: 14),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  '测试4',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorUtils.c333333, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        left: 0,
                        top: 75,
                        onClick: () {},
                      ),
                    ),
                  );
                },
                iconUrl: 'images/cue_arrow_down.png',
              ),
            ),
          ),
          body: dataValue == null
              ?(noData?Container(child: Text('没有数据'),): Container())
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: NestedScrollView(
                          controller: _scrollViewController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                pinned: true,
                                floating: true,
                                elevation: 0.0,
                                leading: Container(),
                                expandedHeight: 310,
                                flexibleSpace: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.pin,
                                  background: Container(
                                    margin: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ///客户姓名====
                                                Flex(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Text(
                                                      '${dataValue['customer'] != null ? dataValue['customer']['name'] ?? '' : ''}',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: ColorUtils
                                                              .c333333),
                                                    ),
                                                    Offstage(offstage: StringUtils.isEmpty(dataValue['salesProcessName']),
                                                      child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 6, left: 12),
                                                      child: Text(
                                                        "${dataValue['salesProcessName'] ?? ''}",
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color: Color(
                                                                0xFFE4B974)),
                                                      ),
                                                      color: Color.fromRGBO(
                                                          228, 185, 116, 0.41),
                                                      padding: EdgeInsets.only(
                                                          left: 6, right: 6),
                                                    ),),
                                                  ],
                                                ),

                                                ///==客户年龄 手机号
                                                Flex(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Text(
                                                      '${dataValue['customer'] != null ? dataValue['customer']['age'] ?? '' : ''}',
                                                      style: TextStyle(
                                                          height: 2.0,
                                                          fontSize: 14,
                                                          color: ColorUtils
                                                              .c444444_60),
                                                    ),
                                                    Text(
                                                      '  |  ',
                                                      style: TextStyle(
                                                          height: 2.0,
                                                          fontSize: 14,
                                                          color: ColorUtils
                                                              .cE8E8E8),
                                                    ),
                                                    Text(
                                                      '${dataValue['customer'] != null ? (dataValue['customer']['phone'] ?? '') : ''}',
                                                      style: TextStyle(
                                                          height: 2.0,
                                                          fontSize: 14,
                                                          color: ColorUtils
                                                              .c444444_60),
                                                    ),
                                                  ],
                                                ),

                                                /// 客户===标签 tag============
                                                Flex(
                                                  direction: Axis.horizontal,
                                                  children: _tag(),
                                                ),
                                              ],
                                            ),

                                            ///圆形图像
                                           ImageUtils.img_circle('https://p0.ssl.qhimg.com/t0183421f63f84fccaf.gif', radius: 102)
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                        _buildButtons(),
//                                  _buildTabBarBg()
                                      ],
                                    ),
                                  ),
                                ),
                                bottom: TabBar(
                                    controller: _tabController,
                                    tabs: [
                                      Tab(text: "重要信息"),
                                      Tab(text: "房屋信息"),
                                      Tab(text: "装修信息"),
                                      Tab(text: "补充信息"),
                                      Tab(text: "客户信息"),
                                      Tab(text: "线索信息"),
                                    ],
                                    isScrollable: true,
                                    indicatorWeight: 1.0,
                                    indicatorColor: ColorUtils.cE4B974,
                                    labelColor: ColorUtils.c444444,
                                    unselectedLabelColor: ColorUtils.c444444_60,
                                    unselectedLabelStyle:
                                        TextStyle(fontWeight: FontWeight.w400),
                                    labelStyle: TextStyle(
                                        height: 1.2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    indicatorPadding: EdgeInsets.only(
                                        left: 30, right: 30, bottom: 10)),
                              )
                            ];
                          },
                          body:
                              TabBarView(controller: _tabController, children: [
                            _buildListView(1),
                            _buildListView(2),
                            _buildListView(3),
                            _buildListView(4),
                            _buildListViewCustomerInfo(),
                            _buildListView(6),
                          ])),
                    ),
                    Divider(
                      height: 2,
                      color: ColorUtils.lineColor,
                    ),

                    /// 底部按钮控件
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          _bottomButtonItem('images/chart_2x.png', '聊天'),
                          _bottomButtonItem('images/invalid_2x.png', '死单'),
                          _bottomButtonItem('images/important_y_2x.png', '重要'),
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(left: 12, right: 12),
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    "拨打电话",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorUtils.c444444),
                                  ),
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: ColorUtils.c444444)),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(left: 12, right: 12),
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    "添加跟进",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorUtils.c444444),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: ColorUtils.cE4B974,
                                ),
                              ))
                            ],
                          )),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    )
                  ],
                )),
    );
  }

  /// 客户标签  tag
  _tag() {
    var tagList = <Widget>[];
    if (dataValue['customer'] != null &&
        dataValue['customer']['labelNames'] != null) {
      String lable = dataValue['customer']['labelNames'].toString();
      List<String> list = lable.split(",");
      list.forEach((v) {
        tagList.add(Container(
          constraints: BoxConstraints(minWidth: 52),
          height: 28,
          margin: EdgeInsets.only(right: 7, top: 8),
          child: Center(
            child: Text(
              v,
              style: TextStyle(color: ColorUtils.c444444, fontSize: 12),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: ColorUtils.c444444_30),
          ),
        ));
      });
    }
    return tagList;
  }

//  https://www.jianshu.com/p/d96508c9d174
//  Widget _buildBanner() {
//    return Container(
//      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
//      height: 144,
//      child: Swiper(//第三方的banner库：flutter_swiper
//          itemBuilder: (BuildContext context, int index) {
//            return Container(
//              width: double.infinity,
//              height: 144,
//              child: Image.network(
//                "https://github.com/best-flutter/flutter_swiper/raw/master/banner.jpg",
//                height: double.infinity,
//                fit: BoxFit.fill,
//              ),
//            );
//          },
//          itemCount: 3,
//          scale: 0.9,
//          pagination: new SwiperPagination()),
//    );
//  }

  /// card 客户地址
  Widget _buildButtons() {
    return Card(
      margin: EdgeInsets.only(top: 30),
      elevation: 5.0,
      child: Container(
//        decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadius.circular(8.0),
//            boxShadow: [
//              BoxShadow(
//                  color: Colors.black12,
//                  offset: Offset(1, 1.0), //阴影xy轴偏移量
//                  blurRadius: 9.0, //阴影模糊程度
//                  spreadRadius: 2.0 //阴影扩散程度
//              )
//            ]),

        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${address??''}',
              style: TextStyle(
                  color: ColorUtils.c444444_60, fontSize: 12, height: 1.5),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 14,
              ),
              child: Divider(
                height: 1,
                color: ColorUtils.lineColor,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Chip(
                  label: Text(
                    '线索一生',
                    style: TextStyle(fontSize: 14, color: ColorUtils.c444444),
                  ),
                  avatar: Image.asset(
                    'images/xiansuo_2x.png',
                    width: 20,
                    height: 20,
                  ),
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.white,
                )),
                Container(
                  width: 2,
                  height: 18,
                  color: ColorUtils.lineColor,
                ),
                Expanded(
                    child: Chip(
                  label: Text('最新图纸',
                      style:
                          TextStyle(fontSize: 14, color: ColorUtils.c444444)),
                  avatar: Image.asset(
                    'images/xiansuo_2x.png',
                    width: 20,
                    height: 20,
                  ),
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.white,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonItem(IconData icon, String text) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 28.0),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(text,
              style: TextStyle(color: Color(0xff999999), fontSize: 12)),
        )
      ],
    ));
  }

  Widget _bottomButtonItem(String iconUrl, String text) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 46,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              iconUrl,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
            Text(text,
                style: TextStyle(
                    color: ColorUtils.c444444, fontSize: 12, height: 1.6))
          ],
        ),
      ),
    );
  }

  ///RelativeRect.fromLTRB(190, 74, 1.0, 0.0)
  void _popuMenu2() {
    var pop = _popuMenuBtn();
    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: RelativeRect.fromLTRB(1.0, 74, 0.1, 0.0),
    ).then<void>((String newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  PopupMenuButton _popuMenuBtn() {
    return PopupMenuButton<String>(
      onCanceled: () {
        print('object');
      },
      onSelected: _backValue,
      itemBuilder: (context) => _getPopupMenu(context),
    );
  }

  OverlayEntry weixinOverlayEntry;

  ///关闭overlay
  void _overlayRemove() {
    if (weixinOverlayEntry != null) {
      weixinOverlayEntry.remove();
      weixinOverlayEntry = null;
    }
  }

  ///展示下拉的弹窗
  void showPopupView() {
    if (weixinOverlayEntry != null) {
      _overlayRemove();
      return;
    }
    weixinOverlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
          top: kToolbarHeight,
          right: 0,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: GestureDetector(
            onTap: () {
              _overlayRemove();
            },
            child: new SafeArea(
                child: new Material(
              color: Colors.black26,
              child: new Container(
                color: Colors.black,
                margin: EdgeInsets.only(bottom: 200),
                child: new Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      title: new Text(
                        "发起群聊",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.add, color: Colors.white),
                      title: new Text("添加朋友",
                          style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.add, color: Colors.white),
                      title: new Text("扫一扫",
                          style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.add, color: Colors.white),
                      title: new Text("首付款",
                          style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.add, color: Colors.white),
                      title: new Text("帮助与反馈",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )),
          ));
    });
    Overlay.of(context).insert(weixinOverlayEntry);
  }

  Function _backValue(v) {
    print('object $v');
//    return null;
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: '语文',
        child: Text('语文'),
      ),
      PopupMenuItem<String>(
        value: '数学',
        child: Text('数学'),
      ),
      PopupMenuItem<String>(
        value: '英语',
        child: Text('英语'),
      ),
      PopupMenuItem<String>(
        value: '生物',
        child: Text('生物'),
      ),
      PopupMenuItem<String>(
        value: '化学',
        child: Text('化学'),
      ),
    ];
  }

//  ————————————————
//  版权声明：本文为CSDN博主「马志武」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
//  原文链接：https://blog.csdn.net/ruoshui_t/article/details/95172953
  Widget _buildTabBarBg() {
    return Container(
      //TabBar圆角背景颜色
      height: 40,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(color: Colors.white)),
    );
  }

  List<String> tag1 = const [
    '线索编号',
    '来源渠道',
    '转化工具',
    '房屋结构',
    '意向风格',
    '当前跟进人',
    ' '
  ];
  List<String> tag2 = const [
    '工程地址',
    '房屋结构',
    '房屋面积',
    '实测面积',
    '房屋用途',
    '目前装修情况',
    ' '
  ];
  List<String> tag3 = const [
    '意向套餐',
    '选择贷款',
    '居住人口总数',
    '小孩数',
    '老人数',
    '预计装修日期',
    '预计入住日期'
  ];
  List<String> tag4 = const [
    '装修预算',
    '意向风格',
    '房屋类型',
    '来源渠道',
    '客户关注点',
    '反馈人',
    '搜索词'
  ];

  List<String> tag6 = const ['当前跟进人', '当前跟进部门', '转化工具', '着陆平台', '', '', ''];
  Widget _buildListView(int tagIndex) {
    List<String> tag;
    List<String> value = List();
    switch (tagIndex) {
      case 1:
        tag = ['线索编号', '来源渠道', '转化工具', '房屋结构', '意向风格', '当前跟进人', ' '];
        var v = dataValue['businessCorrelation'] != null
            ? dataValue['businessCorrelation']['business'] ?? {}
            : {};
        value.add(v['code'] ?? '');
        value.add(v['channelName'] ?? '');
        value.add(v['transformToolName'] ?? '');
        value.add((dataValue['houseStructureCode'] ?? '') + '需要操作数据库获取');
        value.add('需要操作数据库获取');
        value
            .add((v['followUpUserName'] ?? '') + '   ' + v['followUpDeptName']);
        value.add('');
        break;
      case 2:
        tag = ['工程地址', '房屋结构', '房屋面积', '实测面积', '房屋用途', '目前装修情况', ' '];
        StringBuffer stringBuffer = StringBuffer();
        stringBuffer.write(dataValue['provinceName'] ?? '');
        stringBuffer.write(dataValue['cityName'] ?? '');
        stringBuffer.write(dataValue['areaName'] ?? '');
        stringBuffer.write(dataValue['estateName'] ?? '');
        stringBuffer.write(dataValue['houseAddress'] ?? '');
        value.add(stringBuffer.toString());
        String area= dataValue['conArea'].toString().isEmpty? '':'     '+dataValue['conArea'].toString()+'平米';
        stringBuffer.write(area);
        stringBuffer.write('     数据获取不是现房');
        setState(() {
          address=stringBuffer.toString();
        });
        
        value.add('需要操作数据库获取');
        value.add('' + (dataValue['conArea'] ?? '').toString() + ' m²');
        value.add('' + (dataValue['usageArea'] ?? '').toString() + ' m²');
        value.add('需要操作数据库获取');
        value.add('需要操作数据库获取');
        value.add('');
        break;
      case 3:
        tag = ['意向套餐', '选择贷款', '居住人口总数', '小孩数', '老人数', '预计装修日期', '预计入住日期'];
        Map<String, dynamic> v = dataValue['businessCorrelation'] != null
            ? dataValue['businessCorrelation']['business'] ?? {}
            : {};
        print('****************************************');
        MyLog.d(v);
        bool c = v.containsKey('proTemplateName');
        if (c) {
          value.add('' + (v['proTemplateName'] ?? '').toString());
        } else {
          value.add('');
        }

        value.add('' + '需要操作数据库获取');

        value.add((v['totalPeopleNum'] ?? '').toString());
        value.add((v['childPeopleNum'] ?? '').toString());
        value.add((v['oldPeopleNum'] ?? '').toString());
        int t = v['expectedDecorationDate'] ?? 0;
        if (t > 0) {
          value.add(
              DateTime.fromMillisecondsSinceEpoch(v['expectedDecorationDate'])
                  .toIso8601String());
        } else {
          value.add('');
        }
        int t2 = v['expectedMoveDate'] ?? 0;
        if (t2 > 0) {
          value.add(DateTime.fromMillisecondsSinceEpoch(v['expectedMoveDate'])
              .toIso8601String());
        } else {
          value.add('');
        }

        value.add('');
        break;
      case 4:
        tag = ['装修预算', '意向风格', '房屋类型', '来源渠道', '客户关注点', '反馈人', '搜索词'];

        var v = dataValue['businessCorrelation'] != null
            ? dataValue['businessCorrelation']['business'] ?? {}
            : {};
        value.add('需要操作数据库获取');
        value.add('需要操作数据库获取');
        value.add(v['decorationBudget'] ?? '');
        value.add(v['channelName'] ?? '');
        value.add(v['customerFocus'] ?? '');
        value.add(v['feedbackUserName'] ?? '为空就在个人信息去字段');
        break;
      case 6:
        tag = ['当前跟进人', '当前跟进部门', '转化工具', '着陆平台', '', '', ''];
        var v = dataValue['businessCorrelation'] != null
            ? dataValue['businessCorrelation']['business'] ?? {}
            : {};
        value.add(v['followUpUserName'] ?? '');
        value.add(v['followUpDeptName'] ?? '');
        value.add(v['transformToolName'] ?? '');
        value.add(v['landPlatformName'] ?? '');
        value.add('');
        value.add('');
        break;
    }
    return ListView(
      children: <Widget>[
        _itemView(tag[0], value[0]),
        _itemView(tag[1], value[1]),
        _itemView(tag[2], value[2]),
        _itemView(tag[3], value[3]),
        _itemView(tag[4], value[4]),
        _itemView(tag[5], value[5]),
      ],
    );
//    return ListView.separated(
//        itemCount: 20,
//        separatorBuilder: (BuildContext context, int index) => Divider(
//              color: Colors.grey,
//              height: 1,
//            ),
//        itemBuilder: (BuildContext context, int index) {
//          return Container(
//              color: Colors.white,
//              child: ListTile(title: Text("$s第$index 个条目")));
//        });
  }

  /// 每一行数据
  _itemView(String key, String v) {
    if (key == null || key == '') {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: Text(
              key,
              style: TextStyle(fontSize: 12, color: ColorUtils.c333333_60),
            ),
          ),
          Text(v, style: TextStyle(fontSize: 12, color: ColorUtils.c333333)),
        ],
      ),
    );
  }

  ///  客户信息tabview
  Widget _buildListViewCustomerInfo() {
    List<String> tag = const [
      '微信',
      'QQ',
      '联系地址',
      '年龄',
      '生日',
      '证件类型',
      '证件号码',
      '血型',
      '职业',
      '喜欢的风格',
      '重要级别',
      '介绍人类型',
      '介绍人手机号',
      '介绍人姓名',
      '联系人信息'
    ];
    List<String> value = List();

    var v = dataValue['customer'] ?? {};
    value.add((v['wechatNumber'] ?? '').toString());
    value.add((v['qqNumber'] ?? '').toString());

    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write(v['provinceName'] ?? '');
    stringBuffer.write(v['cityName'] ?? '');
    stringBuffer.write(v['areaName'] ?? '');
    stringBuffer.write(v['estateName'] ?? '');
    stringBuffer.write(v['detailedAddress'] ?? '');
    value.add(stringBuffer.toString());

    value.add((v['age'] ?? '').toString());
    value.add((v['birthday'] ?? '').toString());
    value.add('需要数据库查询');
    value.add((v['documentCode'] ?? '').toString());
    value.add('需要数据库查询');
    value.add('需要数据库查询');
    value.add('需要数据库查询');
    value.add('需要数据库查询');
    int type = (v['introducerType'] ?? 0).toInt();
    String t = '';
    switch (type) {
      case 1:
        t = '工长';
        break;
      case 2:
        t = '设计';
        break;
      case 3:
        t = '客户';
        break;
    }
    value.add(t);
    value.add((v['introducerPhone'] ?? '').toString());
    value.add(v['introducerName'] ?? '');
    value.add('');
    var childList = <Widget>[];
    childList.add(_itemView(tag[0], value[0]));
    childList.add(_itemView(tag[1], value[1]));
    childList.add(_itemView(tag[2], value[2]));
    childList.add(_itemView(tag[3], value[3]));
    childList.add(_itemView(tag[4], value[4]));
    childList.add(_itemView(tag[5], value[5]));
    childList.add(_itemView(tag[6], value[6]));
    childList.add(_itemView(tag[7], value[7]));
    childList.add(_itemView(tag[8], value[8]));
    childList.add(_itemView(tag[9], value[9]));
    childList.add(_itemView(tag[10], value[10]));
    childList.add(_itemView(tag[11], value[11]));
    childList.add(_itemView(tag[12], value[12]));
    childList.add(_itemView(tag[13], value[13]));
    childList.add(_itemView(tag[14], value[14]));

    ///联系人列表
    List<dynamic> contacts = dataValue['contactsList'] ?? [];
    contacts.forEach((item) {
//  private String linkman;
//  private String relation;
//  private String phone;
//  private int sortNum;
      String title = item['linkman'] ?? '' + '    ' + item['relation'] ?? '';
      childList.add(
        Container(
          margin: EdgeInsets.only(top: 12, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 12, color: ColorUtils.c333333),
              ),
              Text(
                (item['phone'] ?? '').toString(),
                style: TextStyle(
                    fontSize: 12, color: ColorUtils.c333333, height: 2.0),
              )
            ],
          ),
        ),
      );
    });
    return ListView(
      children: childList,
    );
  }
/// 弹框数据 popupwindow
_popupListData(){
    List<String> list=List();

    return list;
}
  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }
}
