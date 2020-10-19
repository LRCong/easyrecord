import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../db/db_helper.dart';
import '../../models/bill_model.dart';
import 'package:intl/intl.dart';

class SumItem {
  List<Item> list;
  double income;
  double outcome;

  SumItem() {
    list = [];
    income = outcome = 0;
  }
}

enum selectedTypes { none, time, category, account, member }

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnalysisPageState();
  }
}

class _AnalysisPageState extends State<StatefulWidget> {
  selectedTypes _selectedType; //时间，分类， 账户， 成员
  String _time;
  String _category;
  List<Item> _itemList = [];
  List<SumItem> _sum = [];
  TextStyle bigFont = TextStyle(fontSize: 25);
  TextStyle smallFont = TextStyle(fontSize: 20);

  // TODO: 本年度记录，需要添加按钮切换年份
  final endTime = DateTime.now();

  // @override
  // void initState(){
  //   super.initState();
  //   _selectedType = selectedTypes.time;
  //   _time = '月';
  //   // getItemList();
  //   // getSumList();
  // }

  void getItemList() {
    _itemList.clear();
    dbHelp
        .getAcount(
      startTime: 0,
      endTime: 1701125919708,
    )
        .then((value) {
      if (value == null) return;
      for (int i = 0; i < value.length; i++) {
        Item tmp = Item.fromMap(value[i]);
        _itemList.add(tmp);
      }
      print("\n\nNot Sorted _itemList is: ");
      for (int i = 0; i < _itemList.length; ++i) {
        Item item = _itemList[i];
        var date = DateFormat('yyyy-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp));
        print(
            "$i item is: ${item.cost},  $date, ${item.mainType}, ${item.subType}, ${item.member}, type ${item.type}");
      }
      _itemList.sort((a, b) => a.createTimeStamp.compareTo(b.createTimeStamp));
      print("Sorted _itemList is: ");
      for (int i = 0; i < _itemList.length; ++i) {
        Item item = _itemList[i];
        var date = DateFormat('yyyy-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp));
        print(
            "$i item is: ${item.cost},  $date, ${item.mainType}, ${item.subType}, ${item.member}");
      }
    });
  }

  Function ParseTime;
  Function ParseString;

  void getFunction() {
    switch (_selectedType) {
      case selectedTypes.none:
        assert(false);
        break;
      case selectedTypes.time:
        switch (_time) {
          case '年':
            ParseTime = (Item item) {
              var time =
                  DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
              return DateTime(time.year);
            };
            break;
          case '季':
            ParseTime = (Item item) {
              var time =
                  DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
              var quarter = (time.month - 1) ~/ 3 + 1;
              return DateTime(time.year, quarter);
            };
            break;
          case '月':
            ParseTime = (Item item) {
              var time =
                  DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
              return DateTime(time.year, time.month);
            };
            break;
          case '周':
            ParseTime = (Item item) {
              var time =
                  DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
              return DateTime(time.year, time.month, time.day);
            };
            break;
          case '天':
            ParseTime = (Item item) {
              var time =
                  DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
              return DateTime(time.year, time.month, time.day);
            };
            break;
          case '时':
            ParseTime = (Item item) {
              var time =
                  DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);
              return DateTime(time.year, time.month, time.day, time.hour);
            };
            break;
        }
        break;
        break;
      case selectedTypes.category:
        if (_category == '一级分类')
          ParseString = (Item item) => item.mainType;
        else
          ParseString = (Item item) => item.subType;
        break;
      case selectedTypes.account:
        ParseString = (Item item) => item.account;
        break;
      case selectedTypes.member:
        ParseString = (Item item) => item.member;
    }
  }

  void getSumList() {
    _sum.clear();
    getFunction();
    var fun;
    if (_selectedType == selectedTypes.time) {
      fun = ParseTime;
    } else {
      fun = ParseString;
    }
    print("Start to compute sumList");
    var res = Map();
    for (Item item in _itemList) {
      var key = fun(item);
      print("key is $key");
      if (res[key] == null) {
        SumItem tmp = new SumItem();
        res[key] = tmp;
      }
      SumItem tmp = res[key];
      tmp.list.add(item);

      if (item.type == 1) {
        tmp.outcome += item.cost;
      } else if (item.type == 2) {
        tmp.income += item.cost;
      }
      res[key] = tmp;
    }
    res.forEach((key, value) {
      _sum.add(value);
    });
    print("得到综合条目sum: $_sum");
  }

  getLeadingText(int i) {
    String title = 'No title';
    Text sub;
    TextStyle grey = TextStyle(color: Colors.grey);

    switch (_selectedType) {
      case selectedTypes.none:
        assert(false);
        break;
      case selectedTypes.time:
        DateTime today = DateTime.fromMillisecondsSinceEpoch(
            _sum[i].list[0].createTimeStamp);
        sub = Text(
          today.year.toString(),
          style: grey,
        );
        switch (_time) {
          case '年':
            title = today.year.toString() + '年';
            break;
          case '季':
            int quarter = (today.month - 1) ~/ 3 + 1;
            title = quarter.toString() + '季';
            break;
          case '月':
            title = today.month.toString() + '月';
            break;
          case '周':
            var week = today.day ~/ 7 + 1;
            title = week.toString() + '周';
            break;
          case '天':
            title = today.day.toString() + '日';
            sub = Text(
              DateFormat('yyyy. MM').format(today),
              style: grey,
            );
            break;
          case '时':
            title = (today.hour + 1).toString() +
                '点-' +
                today.hour.toString() +
                '点';
            break;
        }
        break;
        break;
      case selectedTypes.category:
        if (_category == '一级分类')
          title = _sum[i].list[0].mainType;
        else
          title = _sum[i].list[0].subType;
        break;
      case selectedTypes.account:
        title = _sum[i].list[0].account;
        break;
      case selectedTypes.member:
        title = _sum[i].list[0].member;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 3),
          child: Text(
            title,
            style: _selectedType == selectedTypes.time &&
                    (_time == '天' ||
                        _time == '周' ||
                        _time == '月' ||
                        _time == '季')
                ? bigFont
                : smallFont,
          ),
        ),
        _selectedType == selectedTypes.time ? sub : Text(' ')
      ],
    );
  }

  void PressButton(button, choose) {
    _selectedType = button;
    if (button == selectedTypes.time) {
      _time = choose;
    } else if (button == selectedTypes.category) {
      _category = choose;
    }
    if (_itemList.length == 0) getItemList();
    getSumList();
  }


  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true; //显示边界布局然后自动import即可
    getItemList();
    return new Scaffold(
      appBar: new AppBar(title: new Text('${endTime.year}年')),
      //TODO :添加年份选择，添加新建选项
      body: new ListView.separated(
          itemCount: _sum.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (context, i) {
            return new ExpansionTile(
              //TODO: 添加具体时间下拉块
              initiallyExpanded: i == 0 ? true : false,
              leading: getLeadingText(i),
              title: new Row(
                children: [
                  Container(
                    width: 40,
                  ),
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: new RichText(
                            text: TextSpan(
                                text: (_sum[i].income - _sum[i].outcome)
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "  结余",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey))
                                ]),
                          ),
                        ),
                        new RichText(
                          text: TextSpan(
                              text: "收入  ",
                              style: TextStyle(color: Colors.red),
                              children: <TextSpan>[
                                TextSpan(
                                    text: _sum[i].income.toStringAsFixed(2),
                                    style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                    text: "  |  ",
                                    style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                    text: "支出    ",
                                    style: TextStyle(color: Colors.green)),
                                TextSpan(
                                    text: _sum[i].outcome.toStringAsFixed(2),
                                    style: TextStyle(color: Colors.grey))
                              ]),
                        ),
                      ]),
                ],
              ),
              children: <Widget>[
                new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _sum[i].list.length,
                    itemBuilder: (context, j) {
                      Item item = _sum[i].list[j];
                      return new InkWell(
                        onTap: (){
                          print("you pressed the list");
                          Navigator.pushNamed(context, "/Edit");
                        },
                        child:ListTile(
                          leading: Icon(
                              item.type <= 2
                                  ? Icons.done
                                  : Icons.account_balance_wallet,
                              color: Theme.of(context).primaryColor),
                          title: new Text(item.type <= 2
                              ? "${item.subType}"
                              : "${item.outAccount} -> ${item.inAccount}"),
                          subtitle: new Text(
                              '${formatDate(DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp), [
                                hh,
                                ':',
                                mm
                              ])}' +
                                  (item.type <= 2 ? ' · ${item.account}' : '')),
                          trailing: new Text("${item.cost}"),
                        )
                      );
                    }),
              ],
            );
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 30),
                child: new PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {
                        PressButton(selectedTypes.time, value);
                      });
                    },
                    initialValue:
                        _selectedType == selectedTypes.time ? _time : '',
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: '年',
                            child: Center(child: Text('年')),
                          ),
                          const PopupMenuItem<String>(
                            value: '季',
                            child: Center(child: Text('季')),
                          ),
                          const PopupMenuItem<String>(
                            value: '月',
                            child: Center(child: Text('月')),
                          ),
                          const PopupMenuItem<String>(
                            value: '周',
                            child: Center(child: Text('周')),
                          ),
                          const PopupMenuItem<String>(
                            value: '天',
                            child: Center(child: Text('天')),
                          ),
                          const PopupMenuItem<String>(
                            value: '时',
                            child: Center(child: Text('时')),
                          ),
                        ],
                    child: Row(
                      children: <Widget>[
                        Text(
                          _selectedType == selectedTypes.time ? _time : '时间',
                          style: TextStyle(
                            color: _selectedType == selectedTypes.time
                                ? Colors.yellow[800]
                                : Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_up,
                          color: _selectedType == selectedTypes.time
                              ? Colors.yellow[800]
                              : Colors.black,
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: new PopupMenuButton<String>(
                    onSelected: (String result) {
                      setState(() {
                        PressButton(selectedTypes.category, result);
                      });
                    },
                    initialValue: _selectedType == selectedTypes.category
                        ? _category
                        : '',
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: '一级分类',
                            child: Center(child: Text('一级分类')),
                          ),
                          const PopupMenuItem<String>(
                            value: '二级分类',
                            child: Center(child: Text('二级分类')),
                          ),
                        ],
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        Text(
                          _selectedType == selectedTypes.category
                              ? _category
                              : '分类',
                          style: TextStyle(
                            color: _selectedType == selectedTypes.category
                                ? Colors.yellow[800]
                                : Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_up,
                          color: _selectedType == selectedTypes.category
                              ? Colors.yellow[800]
                              : Colors.black,
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    PressButton(selectedTypes.account, null);
                  });
                },
                child: new Text('账户',
                    style: TextStyle(
                      color: _selectedType == selectedTypes.account
                          ? Colors.yellow[800]
                          : Colors.black,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    PressButton(selectedTypes.member, null);
                  });
                },
                child: new Text('成员',
                    style: TextStyle(
                      color: _selectedType == selectedTypes.member
                          ? Colors.yellow[800]
                          : Colors.black,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
