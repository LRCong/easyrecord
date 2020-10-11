import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'jh_picker_tool.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransferPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TransferPageState();
  }
}

class _TransferPageState extends State<TransferPage> {
  var theInputType = "现金";
  var theOutputType = "现金";
  var theMember = "本人";
  var theTime = DateTime.now();
  var _cost = TextEditingController();
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
            controller: _cost,
          ),
        ),
        SizedBox(
            height: 375.0, //设置高度
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
                          Icons.input,
                          size: 32.0,
                          color: Colors.blue[500],
                        ),
                        title: Text(theInputType),
                        subtitle: Text("转入账户"),
                        onTap: () {
                          JhPickerTool.showStringPicker(context,
                              data: accountType,
                              normalIndex: 0,
                              title: "请选择账户类型",
                              clickCallBack: (int index, var str) {
                            print(index);
                            setState(() {
                              this.theInputType = str;
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
                          Icons.arrow_back,
                          size: 32.0,
                          color: Colors.blue[500],
                        ),
                        title: Text(theOutputType),
                        subtitle: Text("转出账户"),
                        onTap: () {
                          JhPickerTool.showStringPicker(context,
                              data: accountType,
                              normalIndex: 0,
                              title: "请选择账户类型",
                              clickCallBack: (int index, var str) {
                            print(index);
                            setState(() {
                              this.theOutputType = str;
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
          child: Container(
            width: double.infinity,
            height: 40,
            child: MaterialButton(
              child: Text("保存"),
              onPressed: () {
                print("已保存");
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
    ));
  }
}

const accountType = ["现金", "信用卡", "银行卡", "基金", "虚拟账户"];

var mainType = [
  ["餐饮", "交通"],
];

var subType = [
  ["三餐", "蔬果"],
];

var member = ["本人", "配偶", "子女", "父母", "家庭公用"];
