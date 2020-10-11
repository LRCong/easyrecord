import 'package:date_format/date_format.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recognition/PwControllor.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool check = false;
  int _pay = 10;
  var _now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var tempWhich = getWhichPw();
    tempWhich.then((value) {
      if (value == 1 && check == false) {
        Navigator.pushNamed(context, '/StringPwRecognition').then((value) {
          if (value == true) {
            check = true;
          }
        });
      } else if (value == 2 && check == false) {
        Navigator.pushNamed(context, '/GesturePwRecognition').then((value) {
          if (value == true) {
            check = true;
          }
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _pay++;
          });
        },
        child: Column(children: [
          SizedBox(
              height: 150.0, //设置高度
              child: new Card(
                elevation: 15.0, //设置阴影
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(14.0))), //设置圆角
                child: Container(
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/sea2.jpg",
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  height: 150,
                ),
              )),
          SizedBox(
              height: 350.0, //设置高度
              child: new Card(
                  elevation: 15.0, //设置阴影
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(14.0))), //设置圆角
                  child: new Column(
                      // card只能有一个widget，但这个widget内容可以包含其他的widget
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.history,
                            size: 40,
                            color: Colors.blue,
                          ),
                          title: Text("今天"),
                          subtitle: Text("消费${_pay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入0",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_pay}",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.shopping_cart,
                            size: 40,
                            color: Colors.blue,
                          ),
                          title: Text("本周"),
                          subtitle: Text("消费${_pay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入0",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_pay}",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.line_weight,
                            size: 40,
                            color: Colors.blue,
                          ),
                          title: Text("本月"),
                          subtitle: Text("消费${_pay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入0",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_pay}",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            Icons.calendar_today,
                            size: 40,
                            color: Colors.blue,
                          ),
                          title: Text("本年"),
                          subtitle: Text("消费${_pay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入0",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_pay}",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ])))
        ]));
  }
}
