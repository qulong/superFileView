import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/utils/ColorUtils.dart';

class TextFiledDialog extends Dialog {
  String negativeText;
  String positiveText;
  Function onCloseEvent;
  Function onPositivePressEvent;

  TextFiledDialog({
    Key key,
    this.negativeText = "取消",
    this.positiveText = "确定",
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: const EdgeInsets.only(left: 60, right: 60),
              child: new Column(
                children: <Widget>[
                  new Container(
                    constraints: BoxConstraints(minHeight: 120.0),
                    child: new Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: new IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "跳转至",
                              style: TextStyle(
                                  fontSize: 14.0, color: ColorUtils.c333333),
                            ),
                            Container(
                              width: 80,
                              height: 14,
                              margin: EdgeInsets.only(left: 6, right: 6),
                              child: TextField(
                                maxLength: 3,
                                maxLines: 1,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 14.0, color: ColorUtils.c333333),
                                decoration: InputDecoration(
                                  hintText: '',
                                  counter: null,
                                  counterText: '',
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: ColorUtils.c444444_30),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: ColorUtils.c444444),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "页",
                              style: TextStyle(
                                  fontSize: 14.0, color: ColorUtils.c333333),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton());
    if (positiveText != null && positiveText.isNotEmpty)
      widgets.add(_buildBottomPositiveButton());
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      ),
    );
  }

  Widget _buildBottomCancelButton() {
    return SizedBox(
      width: 60,
      height: 30,
      child: FlatButton(
        onPressed: onCloseEvent,
        child: Text(
          negativeText,
          style: TextStyle(fontSize: 14.0, color: ColorUtils.c333333_60),
        ),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(color: ColorUtils.c333333_20)),
      ),
    );
  }

  Widget _buildBottomPositiveButton() {
    return SizedBox(
      width: 60,
      height: 30,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          positiveText,
          style: TextStyle(fontSize: 14.0, color: ColorUtils.c333333),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: ColorUtils.cE4B974,
      ),
    );
  }
}
