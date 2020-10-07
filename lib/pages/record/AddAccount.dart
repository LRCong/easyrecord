import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'jh_picker_tool.dart';

class AddAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddAcountPageState();
  }
}

class _AddAcountPageState extends State<AddAccountPage> {
  var theType = "现金";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
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
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              size: 32.0,
            ),
            title: Text(theType),
            subtitle: Text("账户类型"),
            onTap: () {
              JhPickerTool.showStringPicker(context,
                  data: accountType,
                  normalIndex: 0,
                  title: "请选择账户类型", clickCallBack: (int index, var str) {
                print(index);
                setState(() {
                  this.theType = str;
                });
              });
            },
          ),
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
