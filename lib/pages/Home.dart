
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recognition/PwControllor.dart';
import 'package:easyrecord/db/db_helper.dart';
import 'package:easyrecord/models/bill_model.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool check = false;
  int _dayPay = 0;
  int _weekPay = 0;
  int _monthPay = 0;
  int _yearPay = 0;
  int _dayGet = 0;
  int _weekGet = 0;
  int _monthGet = 0;
  int _yearGet = 0;

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
    dbHelp
        .getAcount(
      startTime: 0,
      endTime: 1701125919708,
    )
        .then((value) {
      if (value == null) return;
      var day = DateTime.now().day;
      var month = DateTime.now().month;
      var year = DateTime.now().year;
      var newDay = 0;
      var newWeek = 0;
      var newMonth = 0;
      var newYear = 0;
      print(value.length);
      for (int i = 0; i < value.length; i++) {
        Item tmp = Item.fromMap(value[i]);
        var tmpTime = DateTime.fromMillisecondsSinceEpoch(tmp.createTimeStamp);
        if (tmpTime.year != year) continue;
        newYear += tmp.cost;
        if (tmpTime.month != month) continue;
        newMonth += tmp.cost;
        if (day - tmpTime.day < 7 &&
            DateTime.now().weekday - tmpTime.weekday > 0)
          newWeek += tmp.cost;
        else
          continue;
        if (tmpTime.day != day) continue;
        newDay += tmp.cost;
      }
      _dayPay = newDay;
      _weekPay = newWeek;
      _monthPay = newMonth;
      _yearPay = newYear;
      // print(_dayPay);
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          dbHelp
              .getAcount(
            startTime: 0,
            endTime: 1701125919708,
          )
              .then((value) {
            if (value == null) return;
            var day = DateTime.now().day;
            var month = DateTime.now().month;
            var year = DateTime.now().year;
            var newDayPay = 0;
            var newWeekPay = 0;
            var newMonthPay = 0;
            var newYearPay = 0;
            var newDayGet = 0;
            var newWeekGet = 0;
            var newMonthGet = 0;
            var newYearGet = 0;
            print(value.length);
            for (int i = 0; i < value.length; i++) {
              Item tmp = Item.fromMap(value[i]);
              if (tmp.type == 1) {
                var tmpTime =
                    DateTime.fromMillisecondsSinceEpoch(tmp.createTimeStamp);
                if (tmpTime.year != year) continue;
                newYearPay += tmp.cost.toInt();
                if (tmpTime.month != month) continue;
                newMonthPay += tmp.cost.toInt();
                if (day - tmpTime.day < 7 &&
                    DateTime.now().weekday - tmpTime.weekday >= 0)
                  newWeekPay += tmp.cost.toInt();
                else
                  continue;
                if (tmpTime.day != day) continue;
                newDayPay += tmp.cost.toInt();
              } else if (tmp.type == 2) {
                var tmpTime =
                    DateTime.fromMillisecondsSinceEpoch(tmp.createTimeStamp);
                if (tmpTime.year != year) continue;
                newYearGet += tmp.cost.toInt();
                if (tmpTime.month != month) continue;
                newMonthGet += tmp.cost.toInt();
                if (day - tmpTime.day < 7 &&
                    DateTime.now().weekday - tmpTime.weekday >= 0)
                  newWeekGet += tmp.cost.toInt();
                else
                  continue;
                if (tmpTime.day != day) continue;
                newDayGet += tmp.cost.toInt();
              }
            }
            _dayPay = newDayPay;
            _weekPay = newWeekPay;
            _monthPay = newMonthPay;
            _yearPay = newYearPay;
            _dayGet = newDayGet;
            _weekGet = newWeekGet;
            _monthGet = newMonthGet;
            _yearGet = newYearGet;
            setState(() {});
          });
        },
        child: ListView(children: [
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
                          subtitle: Text("消费${_dayPay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入${_dayGet}",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_dayPay}",
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
                          subtitle: Text("消费${_weekPay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入${_weekGet}",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_weekPay}",
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
                          subtitle: Text("消费${_monthPay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入${_monthGet}",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_monthPay}",
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
                          subtitle: Text("消费${_yearPay}"),
                          trailing: Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "收入${_yearGet}",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "支出${_yearPay}",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ])))
        ]));
  }
}
