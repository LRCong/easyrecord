import 'package:flutter/material.dart';
import '../../db/db_helper.dart';
import '../../models/bill_model.dart';
import 'package:date_format/date_format.dart';

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnalysisPageState();
  }
}

enum selectedTypes { none, time, category, account, project, more }

class _AnalysisPageState extends State<StatefulWidget> {
  selectedTypes _enableType = selectedTypes.time; //时间，分类， 账户， 项目， 更多
  String time = '月';
  String category = '一级分类';
  String more = '成员';

  var itemList = <Item>[];

  Widget build(BuildContext context) {
    // itemList.clear();
    dbHelp
        .getAcount(
      startTime: 0,
      endTime: 1701125919708,
    )
        .then((value) {
      if (value == null) return;
      print(value.length);
      for (int i = 0; i < value.length; i++) {
        Item tmp = Item.fromMap(value[i]);
        print(tmp.id);
        print(tmp.cost);
        print(tmp.createTimeStamp);
        itemList.add(tmp);
        print("get itemList as $itemList");
      }
    });

    return new Scaffold(
      appBar: new AppBar(title: new Text('您的记账记录如下')),
      // body: _buildListResult(),
      body: new ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return new ListTile(
            leading: new Icon(Icons.done_all),
            title: new Text("${itemList[index].subType}"),
            subtitle: new Text(
                '${formatDate(DateTime.fromMillisecondsSinceEpoch(itemList[index].createTimeStamp),
                    [ hh, ':', mm])}'),
            trailing: new Text("${itemList[index].cost}"),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: new PopupMenuButton<String>(
                  onSelected: (String result) {
                    setState(() {
                      _enableType = selectedTypes.time;
                      time = result;
                    });
                  },
                  initialValue: '月',
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '年',
                          child: Text('年'),
                        ),
                        const PopupMenuItem<String>(
                          value: '季',
                          child: Text('季'),
                        ),
                        const PopupMenuItem<String>(
                          value: '月',
                          child: Text('月'),
                        ),
                        const PopupMenuItem<String>(
                          value: '周',
                          child: Text('周'),
                        ),
                        const PopupMenuItem<String>(
                          value: '天',
                          child: Text('天'),
                        ),
                        const PopupMenuItem<String>(
                          value: '时',
                          child: Text('时'),
                        ),
                      ],
                  child: new Text(
                    _enableType == selectedTypes.time?time:'时间',
                    style: TextStyle(
                      color: _enableType == selectedTypes.time
                          ? Colors.yellow[800]
                          : Colors.black,
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: new PopupMenuButton<String>(
                  onSelected: (String result) {
                    setState(() {
                      _enableType = selectedTypes.category;
                      category = result;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '一级分类',
                          child: Text('一级分类'),
                        ),
                        const PopupMenuItem<String>(
                          value: '二级分类',
                          child: Text('二级分类'),
                        ),
                      ],
                  child: new Text(
                    _enableType == selectedTypes.category?category:'分类',
                    style: TextStyle(
                      color: _enableType == selectedTypes.category
                          ? Colors.yellow[800]
                          : Colors.black,
                    ),
                  )),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _enableType = selectedTypes.account;
                });
              },
              child: new Text('账户',
                  style: TextStyle(
                    color: _enableType == selectedTypes.account
                        ? Colors.yellow[800]
                        : Colors.black,
                  )),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _enableType = selectedTypes.project;
                });
              },
              child: new Text('项目',
                  style: TextStyle(
                    color: _enableType == selectedTypes.project
                        ? Colors.yellow[800]
                        : Colors.black,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: new PopupMenuButton<String>(
                  onSelected: (String result) {
                    setState(() {
                      _enableType = selectedTypes.more;
                      more = result;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: '成员',
                      child: Text('成员'),
                    ),
                    const PopupMenuItem<String>(
                      value: '商家',
                      child: Text('商家'),
                    ),
                  ],
                  child: new Text(
                    _enableType == selectedTypes.more?more:'更多',
                    style: TextStyle(
                      color: _enableType == selectedTypes.more
                          ? Colors.yellow[800]
                          : Colors.black,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
