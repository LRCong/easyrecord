import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'jh_picker_tool.dart';
import 'package:date_format/date_format.dart';

import 'package:easyrecord/db/db_helper.dart';

class PayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PayPageState();
  }
}

class _PayPageState extends State<PayPage> {
  var theType = "现金";
  var theMainType = "餐饮";
  var theSubType = "三餐";
  var theMember = "本人";
  var theTime = DateTime.now();
  var dbHelper = Dbhelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
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
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
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
                child: new Column(children: [
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
                            data: accountType, normalIndex: 0, title: "请选择账户类型",
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
                            data: mainType, title: "请选择一级分类", normalIndex: 0,
                            clickCallBack: (var index, var str) {
                          print(index);
                          setState(() {
                            this.theMainType = str;
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
                            data: subType, title: "请选择二级分类", normalIndex: 0,
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
                ]))),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Container(
            width: double.infinity,
            height: 40,
            child: MaterialButton(
              child: Text("保存"),
              onPressed: () {
                print("已保存");
                Navigator.pop(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, "/RecordSetting");
          },
        )
      ],
    );
  }
}

const accountType = ["现金", "信用卡", "银行卡", "基金", "虚拟账户"];

var mainType = [
  "餐饮",
  "交通",
];

var subType = [
  "三餐",
  "蔬果",
];

var member = ["本人", "配偶", "子女", "父母", "家庭公用"];
