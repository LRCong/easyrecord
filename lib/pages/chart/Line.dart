import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)
class LinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LinePageState();
}

class LinePageState extends State {
  int touchedIndex;

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
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'two',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: touchedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'two',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: touchedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
      SizedBox(
        height: 210.0, //设置高度
        child: new Card(
          elevation: 15.0, //设置阴影
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
          child: new Column(
            children: [
              new ListTile(
                title: new Text('支出图表按一级类别',
                    style: new TextStyle(fontWeight: FontWeight.w500)),
                subtitle: new Text('图表类型'),
                leading: new Icon(
                  Icons.view_list,
                  color: Colors.blue[500],
                ),
              ),
              new Divider(),
              new ListTile(
                title: new Text('起始时间',
                    style: new TextStyle(fontWeight: FontWeight.w500)),
                leading: new Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.blue[500],
                ),
              ),
              new ListTile(
                title: new Text('结束时间'),
                leading: new Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 18;
      final double radius = isTouched ? 150 : 140;

      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              titlePositionPercentageOffset: .60);
        case 1:
          return PieChartSectionData(
              color: const Color(0xfff8b250),
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              titlePositionPercentageOffset: .60);
        case 2:
          return PieChartSectionData(
              color: const Color(0xff845bef),
              value: 16,
              title: '16%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              titlePositionPercentageOffset: .60);
        case 3:
          return PieChartSectionData(
              color: const Color(0xff13d38e),
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
              titlePositionPercentageOffset: .60);
        default:
          return null;
      }
    });
  }
}
