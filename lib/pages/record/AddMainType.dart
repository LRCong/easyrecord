import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'jh_picker_tool.dart';
import 'package:easyrecord/db/db_helper.dart';

class AddMainTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddMainTypePageState();
  }
}

class _AddMainTypePageState extends State<AddMainTypePage> {
  var theType = '支出';
  var newMainType = TextEditingController();

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
            controller: newMainType,
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
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ListTile(
            subtitle: Text("将自动添加一个默认子类"),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            width: double.infinity,
            height: 40,
            child: MaterialButton(
              child: Text("保存"),
              onPressed: () {
                print("已保存");
                dbHelp.insertCategory(theType, newMainType.text, "默认");
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
