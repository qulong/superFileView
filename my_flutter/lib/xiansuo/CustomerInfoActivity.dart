import 'package:flutter/material.dart';
import 'package:my_flutter/utils/ColorUtils.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 6);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: BaseViewBar(
            childView: BaseTitleBar("hhh",rightIconUrl: 'images/more_2x.png',rightClick: (){
              print("点击   ===");
//              _popuMenu();
              _popuMenu2();
            },),
          ),
          body: Column(
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
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ///客户姓名====
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: <Widget>[
                                              Text(
                                                '张先生',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: ColorUtils.c333333),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 6, left: 12),
                                                child: Text(
                                                  "待审核",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Color(0xFFE4B974)),
                                                ),
                                                color: Color.fromRGBO(
                                                    228, 185, 116, 0.41),
                                                padding: EdgeInsets.only(
                                                    left: 6, right: 6),
                                              ),
                                            ],
                                          ),

                                          ///==客户性别 手机号
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: <Widget>[
                                              Text(
                                                '32岁',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        ColorUtils.c444444_60),
                                              ),
                                              Text(
                                                '  |  ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorUtils.cE8E8E8),
                                              ),
                                              Text(
                                                '18600568898',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        ColorUtils.c444444_60),
                                              ),
                                            ],
                                          ),

                                          /// 客户===标签 tag============
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: <Widget>[
                                              Container(
                                                constraints: BoxConstraints(minWidth: 52),
                                                height: 28,
                                                margin: EdgeInsets.only(right: 7),
                                                child: Center(child: Text("土豪",style: TextStyle(color: ColorUtils.c444444,fontSize: 12 ),),),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  border: Border.all(color: ColorUtils.c444444_30),
                                                    ),
                                              ),Container(
                                                constraints: BoxConstraints(minWidth: 52),
                                                height: 28,
                                                margin: EdgeInsets.only(right: 7),
                                                child: Center(widthFactor: 1.5,child: Text("土豪土豪",style: TextStyle(color: ColorUtils.c444444,fontSize: 12 ),),),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  border: Border.all(color: ColorUtils.c444444_30),
                                                    ),
                                              ),Container(
                                                constraints: BoxConstraints(minWidth: 52),
                                                height: 28,
                                                margin: EdgeInsets.only(right: 7),
                                                child: Center(child: Text("土豪",style: TextStyle(color: ColorUtils.c444444,fontSize: 12 ),),),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  border: Border.all(color: ColorUtils.c444444_30),
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),

                                      ///圆形图像
                                      Container(
                                          width: 102,
                                          height: 102,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(102),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      'https://pics1.baidu.com/feed/730e0cf3d7ca7bcb43f36b74a7542c65f724a840.jpeg?token=253fd4b42d212a3ea8889082df77b3c8&s=ADE383184C2FFE1F4C82AFC7030070AF')))),
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
                                Tab(text: "重要信息"),
                                Tab(text: "房屋信息"),
                                Tab(text: "装修信息"),
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
                    body: TabBarView(controller: _tabController, children: [
                      _buildListView("aaa:"),
                      _buildListView("bbb:"),
                      _buildListView("ccc:"),
                      _buildListView("aaa:"),
                      _buildListView("bbb:"),
                      _buildListView("ccc:"),
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
                                  fontSize: 14, color: ColorUtils.c444444),
                            ),
                            shape: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: ColorUtils.c444444)),
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
                                  fontSize: 14, color: ColorUtils.c444444),
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

  //banner下面的按钮
  Widget _buildButtons() {
    return Card( margin: EdgeInsets.only(top: 30),elevation: 5,child: Container(margin: EdgeInsets.only(top: 15,left: 15,right: 15),child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('北京北京市丰台区珠江骏景中区9号楼7单元10单元1902室  90平米  现房',style: TextStyle(color: ColorUtils.c444444_60,fontSize: 12,height: 1.5),),
        Divider(height: 1,color: ColorUtils.lineColor,),
        Row(children: <Widget>[
          Expanded(child: Chip(label: Text('线索一生',style: TextStyle(fontSize: 14,color: ColorUtils.c444444),),avatar: Image.asset('images/xiansuo_2x.png',width: 20,height: 20,),shape: RoundedRectangleBorder(),backgroundColor: Colors.white,)),
          Container(width: 2,height: 18,color: ColorUtils.lineColor,),
          Expanded(child: Chip(label: Text('最新图纸',style: TextStyle(fontSize: 14,color: ColorUtils.c444444)),avatar: Image.asset('images/xiansuo_2x.png',width: 20,height: 20,),shape: RoundedRectangleBorder(),backgroundColor: Colors.white,))
        ],)
      ],),),);
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
void _popuMenu(){
  showMenu(
    context: context,
    items: <PopupMenuEntry>[
      //items 子项
      PopupMenuItem(
        value: '1',
        child: Text('Item 1',style: TextStyle(fontSize: 14,color: ColorUtils.c333333),),
      ),
      PopupMenuItem(
        value: '2',
        child: Text('Item 2',style: TextStyle(fontSize: 14,color: ColorUtils.c333333),),
      ), PopupMenuItem(
        value: '3',
        child: Text('Item 3',style: TextStyle(fontSize: 14,color: ColorUtils.c333333),),
      ), PopupMenuItem(
        value: '4',
        child: Text('Item 4',style: TextStyle(fontSize: 14,color: ColorUtils.c333333),),
      ),


//      // 分割线
//      PopupMenuDivider(),
//      // 带有复选标记的子项
//      CheckedPopupMenuItem(
//        value: '2',
//        child: Text('Item 2'),
//        checked:true,
//      ),
    ],
    position: RelativeRect.fromLTRB(190, 74, 1.0, 0.0),
  );
}

  void _popuMenu2(){
    var pop=_popuMenuBtn();
    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: RelativeRect.fromLTRB(190, 74, 1.0, 0.0),
    ).then<dynamic>((newValue){
      if (!mounted) return;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }
  PopupMenuButton _popuMenuBtn(){
  return PopupMenuButton<String>(
    onCanceled: (){
      print('object');
    },
    onSelected: (String v){
      print('object   $v');
    },
    itemBuilder:(context)=>_getPopupMenu(context) ,
  );
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

  Widget _buildListView(String s) {
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey,
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.white,
              child: ListTile(title: Text("$s第$index 个条目")));
        });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }
}
