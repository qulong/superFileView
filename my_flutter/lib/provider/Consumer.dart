// 这是一个便捷类，会获得当前context和指定数据类型的Provider
import 'package:flutter/material.dart';
import 'package:my_flutter/provider/ChangeNotifierProvider.dart';

class Consumer<T> extends StatelessWidget {
  Consumer({
    Key key,
    @required this.builder,
    this.child,
  })  : assert(builder != null),
        super(key: key);

  final Widget child;

  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context), //自动获取Model
    );
  }
}