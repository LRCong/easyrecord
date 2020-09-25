import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';

import 'PwControllor.dart';

class GesturePwSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GesturePwSettingPagePage();
  }
}

class _GesturePwSettingPagePage extends State<GesturePwSettingPage> {
  List<int> result = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWhichPw(-1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置手势密码"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              color: Colors.blue[400],
              child: Stack(
                overflow: Overflow.visible, // 超出部分显示
                children: <Widget>[
                  Positioned(
                    left: (MediaQuery.of(context).size.width - 90) / 2.0,
                    top: 150.0 - 45,
                    child: Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        ///阴影
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).cardColor,
                              blurRadius: 4.0)
                        ],

                        ///形状
                        shape: BoxShape.circle,

                        ///图片
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ExactAssetImage("assets/images/sea1.jpg"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              child: GestureView(
                immediatelyClear: true,
                size: MediaQuery.of(context).size.width - 100,
                onPanUp: (List<int> items) {
                  setState(() {
                    result = items;
                  });
                  setWhichPw(2);
                  setGesturePw(result.toString());
                  Navigator.of(context).pop(true);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
