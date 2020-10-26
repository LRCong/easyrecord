import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../record/jh_picker_tool.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:easyrecord/db/db_helper.dart';
import 'package:easyrecord/models/bill_model.dart';

class EditIncomePage extends StatefulWidget {
  final Item item;

  EditIncomePage(Item item) : item = item;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditIncomePageState(item);
  }
}

class _EditIncomePageState extends State<EditIncomePage> {
  final Item item;

  _EditIncomePageState(this.item);
  var _cost;
  var theType;
  var theMainType;
  var theSubType;
  var theMember;
  var theTime;
  // var _cost = new TextEditingController();
  // var theType = "现金";
  // var theMainType = "工职收入";
  // var theSubType = "工资";
  // var theMember = "本人";
  // var theTime = DateTime.now();
  var dbHelper = Dbhelper();
  List mainTypes = List();
  List subTypes = List();
  List accounts = List();
  List members = List();

  @override
  void initState() {
    super.initState();

    _cost = new TextEditingController.fromValue(
        TextEditingValue(text: item.cost.toString()));
    theType = item.account;
    theMainType = item.mainType;
    theSubType = item.subType;
    theMember = item.member;
    theTime = DateTime.fromMillisecondsSinceEpoch(item.createTimeStamp);


    dbHelp.getIncomeCategory().then((list) {
      print(list.length);
      for (int i = 0; i < list.length; i++) {
        Map map = list[i];
        if (!mainTypes.contains(map["mainType"]))
          mainTypes.add(map["mainType"]);
        if (map["mainType"] == theMainType) subTypes.add(map["subType"]);
        print(theMainType);
      }
    });
    dbHelp.getAccountCategory().then((list) {
      print(list.length);
      for (int i = 0; i < list.length; i++) {
        Map map = list[i];
        if (!accounts.contains(map["account"])) accounts.add(map["account"]);
      }
    });
    dbHelp.getMemberCategory().then((list) {
      print(list.length);
      for (int i = 0; i < list.length; i++) {
        Map map = list[i];
        if (!members.contains(map["member"])) members.add(map["member"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _cost,
                decoration: InputDecoration(
                    icon: Icon(Icons.payment),
                    // labelText: '支出金额',
                    border: UnderlineInputBorder(),
                    filled: false),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40.0,
                  // fontFamily:
                ),
              ),
            ),
            SizedBox(
                height: 465.0, //设置高度
                width: 350.0,
                child: new Card(
                    elevation: 15.0, //设置阴影
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(14.0))), //设置圆角
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.account_balance_wallet,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theType),
                            subtitle: Text("选择账户"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: accountType,
                                  normalIndex: 0,
                                  title: "请选择账户类型",
                                  clickCallBack: (int index, var str) {
                                    print(index);
                                    setState(() {
                                      this.theType = str;
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.menu,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theMainType),
                            subtitle: Text("选择一级分类"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: mainTypes, title: "请选择一级分类", normalIndex: 0,
                                  clickCallBack: (var index, var str) {
                                    print(index);
                                    this.theMainType = str;
                                    subTypes = List();
                                    dbHelp.getIncomeCategory().then((list) {
                                      print(list.length);
                                      for (int i = 0; i < list.length; i++) {
                                        Map map = list[i];
                                        if (map["mainType"] == theMainType)
                                          subTypes.add(map["subType"]);
                                      }
                                      this.theSubType = this.subTypes[0];
                                      setState(() {});
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.label_outline,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theSubType),
                            subtitle: Text("选择二级分类"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: subTypes, title: "请选择二级分类", normalIndex: 0,
                                  clickCallBack: (var index, var str) {
                                    print(index);
                                    setState(() {
                                      this.theSubType = str;
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ListTile(
                            leading: Icon(
                              Icons.people,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(theMember),
                            subtitle: Text("选择成员"),
                            onTap: () {
                              JhPickerTool.showStringPicker(context,
                                  data: member, title: "请选择成员", normalIndex: 0,
                                  clickCallBack: (var index, var str) {
                                    print(index);
                                    setState(() {
                                      this.theMember = str;
                                    });
                                  });
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: ListTile(
                            leading: Icon(
                              Icons.timelapse,
                              size: 32.0,
                              color: Colors.blue[500],
                            ),
                            title: Text(
                                formatDate(theTime, [yyyy, "年", mm, "月", d, "日"])),
                            subtitle: Text("选择时间"),
                            onTap: () {
                              JhPickerTool.showDatePicker(context,
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
                                      this.theTime = DateTime(
                                          int.parse(str.split("-")[0]),
                                          int.parse(str.split("-")[1]),
                                          int.parse(str.split("-")[2]));
                                    });
                                    print(time);
                                  });
                            },
                          ),
                        ),
                      ],
                    ))),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 3,
                        // width: 200,
                        // height: 40,
                        child: new Card(
                          color: Colors.blue,
                          elevation: 15.0, //设置阴影
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(14.0))), //设置圆角
                          child: MaterialButton(
                            child: Text("保存"),
                            onPressed: () {
                              try {
                                num.parse(_cost.text);
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: "请输入合法的金额",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue[400],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              if (_cost.text == "") {
                                Fluttertoast.showToast(
                                    msg: "请输入合法的金额",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue[300],
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                              // print(num.parse(_cost.text));
                              // print(theType);
                              // print(theMainType);
                              // print(theSubType);
                              // print(theMember);
                              // print(theTime.millisecondsSinceEpoch);
                              Item updateItem = Item(
                                  id: item.id,
                                  //注意 插入新账单id需为null， 若传入id则此操作为更新表中对应id的账单
                                  cost: num.parse(_cost.text),
                                  mainType: theMainType,
                                  subType: theSubType,
                                  type: 2,
                                  account: theType,
                                  member: theMember,
                                  createTimeStamp: theTime.millisecondsSinceEpoch);
                              dbHelp
                                  .insertItem(updateItem)
                                  .then((value) => print(value));
                              Navigator.pop(context);
                            },

                            textColor: Colors.white,
                          ),
                        )

                    ),
                    Spacer(flex: 1,),
                    Expanded(
                        flex: 3,
                        child: new Card(
                          elevation: 15.0, //设置阴影
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(14.0))),
                          // child: Container(
                          // padding: EdgeInsets.only(left: 20),
                          // width: 200,
                          // height: 40,
                          color: Colors.red,
                          child: MaterialButton(
                            textColor: Colors.white,
                            child: Text('删除'),
                            onPressed: () {
                              setState(() {
                                dbHelper.deleteAccount(item.id);
                              });
                              Navigator.pop(context);
                            },
                          ),
                          // ),
                        )
                    )
                  ],
                )),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, "/RecordSetting");
              },
            )
          ],
        ));
  }
}

const accountType = ["现金", "信用卡", "银行卡", "基金", "虚拟账户"];

var mainType = [
  "职业收入",
  "其他收入",
];

var subType = [
  "三餐",
  "蔬果",
];

var member = ["本人", "配偶", "子女", "父母", "家庭公用"];
