import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'jh_picker_tool.dart';
import 'package:easyrecord/db/db_helper.dart';

class AddSubTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddSubTypePageState();
  }
}

class _AddSubTypePageState extends State<AddSubTypePage> {
  var theType = "支出";
  var theMainType = "餐饮";
  List mainTypes = List();
  var newSubType = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelp.getOutcomeCategory().then((list) {
      print(list.length);
      for (int i = 0; i < list.length; i++) {
        Map map = list[i];
        if (!mainTypes.contains(map["mainType"]))
          mainTypes.add(map["mainType"]);
      }
    });
  }

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
                icon: Icon(Icons.text_fields),
                // labelText: '支出金额,
                border: UnderlineInputBorder(),
                filled: false),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 40.0,
              // fontFamily:
            ),
            controller: newSubType,
          ),
        ),
        SizedBox(
            height: 200.0, //设置高度
            width: 350.0,
            child: new Card(
              elevation: 15.0, //设置阴影
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))), //设置圆角
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
                      subtitle: Text("类别"),
                      onTap: () {
                        JhPickerTool.showStringPicker(context,
                            data: types,
                            normalIndex: 0,
                            title: "请选类别", clickCallBack: (int index, var str) {
                          print(index);
                          setState(() {
                            this.theType = str;
                            mainTypes = List();
                            if (index == 0) {
                              dbHelp.getOutcomeCategory().then((list) {
                                print(list.length);
                                for (int i = 0; i < list.length; i++) {
                                  Map map = list[i];
                                  if (!mainTypes.contains(map["mainType"]))
                                    mainTypes.add(map["mainType"]);
                                }
                                theMainType = mainTypes[0];
                                setState(() {});
                              });
                            } else {
                              dbHelp.getIncomeCategory().then((list) {
                                print(list.length);
                                for (int i = 0; i < list.length; i++) {
                                  Map map = list[i];
                                  if (!mainTypes.contains(map["mainType"]))
                                    mainTypes.add(map["mainType"]);
                                }
                                theMainType = mainTypes[0];
                                setState(() {});
                              });
                            }
                          });
                        });
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_balance_wallet,
                        size: 32.0,
                        color: Colors.blue[500],
                      ),
                      title: Text(theMainType),
                      subtitle: Text("一级分类"),
                      onTap: () {
                        JhPickerTool.showStringPicker(context,
                            data: mainTypes, normalIndex: 0, title: "请选择一级分类",
                            clickCallBack: (int index, var str) {
                          print(index);
                          setState(() {
                            this.theMainType = str;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
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
                dbHelp.insertCategory(theType, theMainType, newSubType.text);
                print("已保存");
                Navigator.pop(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

const types = ['支出', '收入'];
