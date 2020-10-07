import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'jh_picker_tool.dart';

class AddSubTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddSubTypePageState();
  }
}

class _AddSubTypePageState extends State<AddSubTypePage> {
  var theMainType = "餐饮";

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
          ),
        ),
        SizedBox(
            height: 100.0, //设置高度
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
                      title: Text(theMainType),
                      subtitle: Text("一级分类"),
                      onTap: () {
                        JhPickerTool.showStringPicker(context,
                            data: mainType, normalIndex: 0, title: "请选择一级分类",
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

const accountType = ["现金账户", "信用账户", "金融账户", "投资账户", "虚拟账户"];

var mainType = [
  "餐饮",
  "交通",
];
