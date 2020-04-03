import 'package:flutter/material.dart';

class RankingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RankingView();
  }
}

class RankingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RankingState();
  }
}
class RankingState extends State<RankingView>{
  PageController _pageController=PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[

      PageView.builder(itemBuilder: (ctx,index){
        return RankingChildView(index,4,_pageController);
      },itemCount: 4,controller: _pageController,onPageChanged: (indexPage){

      },),
      /// 顶部按钮
      Positioned(child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            height: 40,
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () {},
              child: Image.asset(
                'images/black_back.png',
                width: 22,
                height: 18,
                fit: BoxFit.contain,
              ),
            ),
          ),
          FlatButton(onPressed: () {

          }, child: Text('本周',style: TextStyle(fontSize: 14,color: Colors.white),))
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),top: 24.0,left: 0.0,right: 0.0,),
    ],

    );

  }
}

class RankingChildView extends StatefulWidget{
  int indexPage=0;
  int pageSize=0;
  bool hasPre=false;
  PageController pageControllerChild;
  RankingChildView(this.indexPage,this.pageSize,this.pageControllerChild){
    if(this.indexPage!=this.pageSize-1&&this.indexPage!=0){
      hasPre=true;
    }else if(this.pageSize>1&&this.indexPage==this.pageSize-1){
      hasPre=true;
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RankingChildState();
  }
}
class RankingChildState extends State<RankingChildView> {
  List<bool> btnState=[true,false,false];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/cloud_design_bg.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Positioned(
          child: Column(
            children: <Widget>[
             
              /// 顶部 左右切换箭头 布局
              Row(
                children: <Widget>[
                  Offstage(
                    child: GestureDetector(
                      onTap: () {
                        widget.pageControllerChild.animateToPage(widget.indexPage-1, duration: Duration(milliseconds: 250), curve: Curves.linear);
//                        widget.pageControllerChild.jumpToPage(widget.indexPage-1);
                      },
                      child: Image.asset(
                        'images/left_scoll.png',
                        width: 40,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    offstage: !widget.hasPre,
                  ),
                  Image.asset(
                    'images/storefront_text.png',
                    width: 180,
                    height: 60,
                    fit: BoxFit.scaleDown,
                  ),
                  Offstage(
                    child: GestureDetector(
                      onTap: () {
                        widget.pageControllerChild.animateToPage(widget.indexPage+1, duration: Duration(milliseconds: 250), curve: Curves.linear);
//                        widget.pageControllerChild.jumpToPage(widget.indexPage+1);
                      },
                      child: Image.asset(
                        'images/right_scoll.png',
                        width: 40,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    offstage: (widget.pageSize-1)==widget.indexPage,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),

              /// 中间数据 布局
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width - 50,
                margin: EdgeInsets.only(top: 35, bottom: 45),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(onTap: (){
                          if(!this.btnState[0]){
                            this.btnState[0]=true;
                            this.btnState[1]=false;
                            this.btnState[2]=false;
                            setState(() {

                            });
                          }
                        },child: Container(
                          height: 30,
                          alignment: Alignment(0.0, 0.0),
                          width: 60,
                          decoration: BoxDecoration(
                            color: this.btnState[0]? Color(0xFFA66623):Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            border: new Border.all(width: 1, color: Color(0xFFA66623)),
                          ),
                          child: Text('按钮1',
                              style:
                              TextStyle(fontSize: 14, color: this.btnState[0]? Colors.white: Color(0xFFA66623))),
                        ),),
                        GestureDetector(onTap: (){
                          if(!this.btnState[1]){
                            this.btnState[0]=false;
                            this.btnState[2]=false;
                            this.btnState[1]=true;
                            setState(() {

                            });
                          }
                        },child: Container(
                          height: 30,
                          width: 60,
                          alignment: Alignment(0.0, 0.0),
                          child: Text(
                            '按钮2',
                            style: TextStyle(fontSize: 14, color:this.btnState[1]? Colors.white: Color(0xFFA66623)),
                          ),
                          decoration: BoxDecoration(
                            color: this.btnState[1]? Color(0xFFA66623):Colors.white,
                            border: new Border(
                                top: BorderSide(width: 1, color: Color(0xFFA66623)),
                                bottom:
                                BorderSide(width: 1, color: Color(0xFFA66623))),
                          ),
                        ),),
                        GestureDetector(onTap: (){
                          if(!this.btnState[2]){
                            this.btnState[0]=false;
                            this.btnState[1]=false;
                            this.btnState[2]=true;
                            setState(() {

                            });
                          }
                        },child: Container(
                          height: 30,
                          width: 60,
                          alignment: Alignment(0.0, 0.0),
                          decoration: BoxDecoration(
                            color: this.btnState[2]? Color(0xFFA66623):Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            border: new Border.all(width: 1, color: Color(0xFFA66623)),
                          ),
                          child: Text('按钮3',
                              style:
                              TextStyle(fontSize: 14, color: this.btnState[2]? Colors.white: Color(0xFFA66623))),
                        )),



                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (c, intdex) {
                          String urlIcon='';
                          if(intdex==0){
                            urlIcon='images/golden.png';
                          }else if(intdex==1){
                            urlIcon='images/silver.png';
                          }else if(intdex==2){
                            urlIcon='images/copper.png';
                          }
                          return Container(child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                alignment: Alignment(0.0, 0.0),
                                width: 45,
                                height: 60,
                                child: intdex < 3
                                    ? Image.asset(
                                  urlIcon,
                                  fit: BoxFit.scaleDown,
                                )
                                    : Text('${intdex + 1}',
                                    textAlign: TextAlign.center,
                                    style: _style_forme()),
                              ),
                              Container(child: Text('名字$intdex', style: _style_forme()),margin: EdgeInsets.only(left: 15,),constraints: BoxConstraints(minWidth: 120),),
                              Text(
                                '金额$intdex元',
                                style: _style_forme(),
                              ),
                            ],
                          ),);
                        },
                        itemCount: 12,
                        itemExtent: 60,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
              ))
            ],
          ),
          top: 64.0,
          left: 0.0,
          right: 0.0,
          bottom: 1,
        ),
      ],
    );
  }

  TextStyle _style_forme() {
    return TextStyle(color: Color(0xFF333333), fontSize: 14);
  }
}
