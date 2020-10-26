import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'PwControllor.dart';

class GesturePwRecognitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GesturePwRecognitionPage();
  }
}

class _GesturePwRecognitionPage extends State<GesturePwRecognitionPage> {
  List<int> result = [];
  String _pw;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWhichPw(-1);
    getGesturePw().then((value) {
      _pw = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("输入手势密码"), automaticallyImplyLeading: false),
      body: WillPopScope(
        child: Container(
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
                  size: MediaQuery.of(context).size.width - 50,
                  onPanUp: (List<int> items) {
                    setWhichPw(2);
                    // print(_pw);
                    if (items.toString() == _pw) {
                      Navigator.of(context).pop(true);
                    } else {
                      // print("错误");
                      // print(_pw);
                      // print(items.toString() == _pw);
                      Fluttertoast.showToast(
                          msg: "请输入正确的密码",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue[300],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              )
            ],
          ),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }
}
