import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:date_format/date_format.dart';

import 'package:easyrecord/db/db_helper.dart';
import 'package:easyrecord/models/bill_model.dart';
import 'indicator.dart';
import 'Colors.dart';
import '../record/jh_picker_tool.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)
class PiePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PiePageState();
}

class PiePageState extends State {
  int touchedIndex;
  var beginTime = DateTime.now().subtract(Duration(days: 7));
  var endTime = DateTime.now();
  var pieType = '支出图表按一级类别';
  List nodes = ["zero", "one", "two", "three"];
  List values = [40, 30, 15, 15];
  int sum = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0))),
        elevation: 5.0,
        color: Colors.white,
        child: Column(children: [
          SizedBox(
            height: 20.0,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                          pieTouchResponse.touchInput is FlPanEnd) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                        print(touchedIndex);
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1.0,
                  centerSpaceRadius: 1.0,
                  sections: showingSections()),
            ),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: getIndicator())
        ]),
      ),
      SizedBox(
        height: 225.0, //设置高度
        child: new Card(
          elevation: 15.0, //设置阴影
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
          child: new Column(
            children: [
              new ListTile(
                  title: new Text(pieType,
                      style: new TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: new Text('图表类型'),
                  leading: new Icon(
                    Icons.view_list,
                    color: Colors.blue[500],
                  ),
                  onTap: () {
                    JhPickerTool.showStringPicker(context,
                        data: pieTypes,
                        normalIndex: 0,
                        title: "请选择图表类型", clickCallBack: (int index, var str) {
                      print(index);
                      this.pieType = str;
                      refreshState();
                    });
                  }),
              new Divider(),
              new ListTile(
                  title: new Text(
                      '起始时间' +
                          "  " +
                          formatDate(beginTime, [yyyy, "年", mm, "月", d, "日"]),
                      style: new TextStyle(fontWeight: FontWeight.w500)),
                  leading: new Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue[500],
                  ),
                  onTap: () {
                    JhPickerTool.showDatePicker(
                      context,
//            dateType: DateType.YMD,
//            dateType: DateType.YM,
//            dateType: DateType.YMD_HM,
//            dateType: DateType.YMD_AP_HM,
                      title: "请选择时间",
//            minValue: DateTime(2020,10,10),
//            maxValue: DateTime(2023,10,10),
//            value: DateTime(2020,10,10),
                      clickCallback: (var str, var time) {
                        setState(() {
                          this.beginTime = DateTime(
                              int.parse(str.split("-")[0]),
                              int.parse(str.split("-")[1]),
                              int.parse(str.split("-")[2]));
                        });
                        print(time);
                        refreshState();
                      },
                    );
                  }),
              new ListTile(
                  title: new Text(
                    '结束时间' +
                        "  " +
                        formatDate(endTime, [yyyy, "年", mm, "月", d, "日"]),
                  ),
                  leading: new Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.blue[500],
                  ),
                  onTap: () {
                    JhPickerTool.showDatePicker(
                      context,
//            dateType: DateType.YMD,
//            dateType: DateType.YM,
//            dateType: DateType.YMD_HM,
//            dateType: DateType.YMD_AP_HM,
                      title: "请选择时间",
//            minValue: DateTime(2020,10,10),
//            maxValue: DateTime(2023,10,10),
//            value: DateTime(2020,10,10),
                      clickCallback: (var str, var time) {
                        setState(() {
                          this.endTime = DateTime(
                              int.parse(str.split("-")[0]),
                              int.parse(str.split("-")[1]),
                              int.parse(str.split("-")[2]));
                        });
                        print(time);
                        print(pieType);
                        refreshState();
                      },
                    );
                  }),
            ],
          ),
        ),
      )
    ]);
  }

  refreshState() {
    switch (pieType) {
      case "支出图表按成员":
        dbHelp
            .getAcount(
          startTime: 0,
          endTime: 1701125919708,
        )
            .then((value) {
          List newNodes = List();
          List newValues = List();
          var newSum = 0;
          print(value.length);
          for (int i = 0; i < value.length; i++) {
            // print(value[i]);
            Item tmp = Item.fromMap(value[i]);
            if (tmp.type != 1) continue;
            print(tmp.createTimeStamp);

            if (beginTime.millisecondsSinceEpoch > tmp.createTimeStamp)
              continue;
            print(endTime.millisecondsSinceEpoch);
            if (endTime.millisecondsSinceEpoch < tmp.createTimeStamp) continue;
            newSum += tmp.cost.toInt();
            if (!newNodes.contains(tmp.member)) {
              newNodes.add(tmp.member);
              newValues.add(tmp.cost);
              continue;
            }
            newValues[newNodes.indexOf(tmp.member)] += tmp.cost;
          }
          print(newNodes);
          print(newValues);
          // print(newSum);
          nodes = newNodes;
          values = newValues;
          sum = newSum;
          setState(() {});
        });
        break;
      case "支出图表按一级类别":
        {
          dbHelp
              .getAcount(
            startTime: 0,
            endTime: 1701125919708,
          )
              .then((value) {
            if (value == null) return;
            List newNodes = List();
            List newValues = List();
            var newSum = 0;
            print(value.length);
            for (int i = 0; i < value.length; i++) {
              // print(value[i]);
              Item tmp = Item.fromMap(value[i]);
              if (tmp.type != 1) continue;
              if (beginTime.millisecondsSinceEpoch > tmp.createTimeStamp)
                continue;
              if (endTime.millisecondsSinceEpoch < tmp.createTimeStamp)
                continue;
              newSum += tmp.cost.toInt();
              if (!newNodes.contains(tmp.mainType)) {
                newNodes.add(tmp.mainType);
                newValues.add(tmp.cost);
                continue;
              }
              newValues[newNodes.indexOf(tmp.mainType)] += tmp.cost;
            }
            print(newNodes);
            print(newValues);
            // print(newSum);
            nodes = newNodes;
            values = newValues;
            sum = newSum;
            setState(() {});
          });
        }
        break;
      case "支出图表按二级类别":
        {
          dbHelp
              .getAcount(
            startTime: 0,
            endTime: 1701125919708,
          )
              .then((value) {
            if (value == null) return;
            List newNodes = List();
            List newValues = List();
            var newSum = 0;
            print(value.length);
            for (int i = 0; i < value.length; i++) {
              // print(value[i]);
              Item tmp = Item.fromMap(value[i]);
              if (tmp.type != 1) continue;
              if (beginTime.millisecondsSinceEpoch > tmp.createTimeStamp)
                continue;
              if (endTime.millisecondsSinceEpoch < tmp.createTimeStamp)
                continue;
              newSum += tmp.cost.toInt();
              if (!newNodes.contains(tmp.subType)) {
                newNodes.add(tmp.subType);
                newValues.add(tmp.cost);
                continue;
              }
              newValues[newNodes.indexOf(tmp.subType)] += tmp.cost;
            }
            print(newNodes);
            print(newValues);
            // print(newSum);
            nodes = newNodes;
            values = newValues;
            sum = newSum;
            setState(() {});
          });
        }
        break;
      case "收入图表按成员":
        dbHelp
            .getAcount(
          startTime: 0,
          endTime: 1701125919708,
        )
            .then((value) {
          List newNodes = List();
          List newValues = List();
          var newSum = 0;
          print(value.length);
          for (int i = 0; i < value.length; i++) {
            // print(value[i]);
            Item tmp = Item.fromMap(value[i]);
            if (tmp.type != 2) continue;
            print(tmp.createTimeStamp);

            if (beginTime.millisecondsSinceEpoch > tmp.createTimeStamp)
              continue;
            print(endTime.millisecondsSinceEpoch);
            if (endTime.millisecondsSinceEpoch < tmp.createTimeStamp) continue;
            newSum += tmp.cost.toInt();
            if (!newNodes.contains(tmp.member)) {
              newNodes.add(tmp.member);
              newValues.add(tmp.cost);
              continue;
            }
            newValues[newNodes.indexOf(tmp.member)] += tmp.cost;
          }
          print(newNodes);
          print(newValues);
          // print(newSum);
          nodes = newNodes;
          values = newValues;
          sum = newSum;
          setState(() {});
        });
        break;
      case "收入图表按一级类别":
        {
          dbHelp
              .getAcount(
            startTime: 0,
            endTime: 1701125919708,
          )
              .then((value) {
            if (value == null) return;
            List newNodes = List();
            List newValues = List();
            var newSum = 0;
            print(value.length);
            for (int i = 0; i < value.length; i++) {
              // print(value[i]);
              Item tmp = Item.fromMap(value[i]);
              if (tmp.type != 2) continue;
              if (beginTime.millisecondsSinceEpoch > tmp.createTimeStamp)
                continue;
              if (endTime.millisecondsSinceEpoch < tmp.createTimeStamp)
                continue;
              newSum += tmp.cost.toInt();
              if (!newNodes.contains(tmp.mainType)) {
                newNodes.add(tmp.mainType);
                newValues.add(tmp.cost);
                continue;
              }
              newValues[newNodes.indexOf(tmp.mainType)] += tmp.cost;
            }
            print(newNodes);
            print(newValues);
            // print(newSum);
            nodes = newNodes;
            values = newValues;
            sum = newSum;
            setState(() {});
          });
        }
        break;
      case "收入图表按二级类别":
        {
          dbHelp
              .getAcount(
            startTime: 0,
            endTime: 1701125919708,
          )
              .then((value) {
            if (value == null) return;
            List newNodes = List();
            List newValues = List();
            var newSum = 0;
            print(value.length);
            for (int i = 0; i < value.length; i++) {
              // print(value[i]);
              Item tmp = Item.fromMap(value[i]);
              if (tmp.type != 2) continue;
              if (beginTime.millisecondsSinceEpoch > tmp.createTimeStamp)
                continue;
              if (endTime.millisecondsSinceEpoch < tmp.createTimeStamp)
                continue;
              newSum += tmp.cost.toInt();
              if (!newNodes.contains(tmp.subType)) {
                newNodes.add(tmp.subType);
                newValues.add(tmp.cost);
                continue;
              }
              newValues[newNodes.indexOf(tmp.subType)] += tmp.cost;
            }
            print(newNodes);
            print(newValues);
            // print(newSum);
            nodes = newNodes;
            values = newValues;
            sum = newSum;
            setState(() {});
          });
        }
        break;
    }
  }

  List<Padding> getIndicator() {
    return List.generate(nodes.length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          children: <Widget>[
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(colors[index]),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              nodes[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: touchedIndex == index ? Colors.black : Colors.grey,
              ),
            )
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(nodes.length, (index) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 25 : 18;
      final double radius = isTouched ? 150 : 140;
      var theTitle = " ";

      return PieChartSectionData(
          color: Color(colors[index]),
          value: double.parse(values[index].toString()),
          title: theTitle,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
          titlePositionPercentageOffset: .60);
    });
  }
}

var pieTypes = [
  "支出图表按一级类别",
  "支出图表按二级类别",
  "支出图表按成员",
  "收入图表按一级类别",
  "收入图表按二级类别",
  "收入图表按成员",
];
