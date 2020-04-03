
import 'package:flutter/material.dart';
import 'package:my_flutter/inherited/InheritedWidgetData.dart';

class InheritedWidgetDemo extends InheritedWidget {
  final InheritedWidgetData data;

  InheritedWidgetDemo({@required this.data, @required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidgetDemo oldWidget) {
    return data != oldWidget.data;
  }

  static InheritedWidgetData of(BuildContext context) {
    final InheritedWidgetDemo user = context.dependOnInheritedWidgetOfExactType();
    return user.data;
  }
}