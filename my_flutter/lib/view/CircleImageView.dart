import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImageView extends StatelessWidget {
  double radius;
  BoxFit fit;
  String url;
  String placeholder;
  CircleImageView(this.radius, this.url,
      {this.fit = BoxFit.cover, this.placeholder});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CircleImage( this.radius, this.url,fit: this.fit,placeholder: this.placeholder,);
  }
}

class CircleImage extends StatefulWidget {
  double radius;
  BoxFit fit;
  String url;
  String placeholder;
  CircleImage(this.radius, this.url,
      {this.fit = BoxFit.cover, this.placeholder});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CircleImageState(this.radius,this.url,fit: this.fit,placeholder: this.placeholder);
  }
}

class CircleImageState extends State<CircleImage> {
  double radius;
  BoxFit fit;
  String url;
  String placeholder;
  bool imgLoadFail = false;
  CircleImageState(this.radius, this.url,
      {this.fit = BoxFit.cover, this.placeholder='images/invalid_2x.png'});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return CircleAvatar(
      //头像半径
      radius: this.radius,
//      child: this.imgLoadFail ? Image.asset(this.placeholder) : Container(),
      //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
      backgroundImage: CachedNetworkImageProvider(
        this.url,
        errorListener: () {
          print('jia jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
          setState(() {
            imgLoadFail = true;
          });
        },
      ),
    );
  }
}
