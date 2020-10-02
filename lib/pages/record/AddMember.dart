import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddMemberPageState();
  }
}

class _AddMemberPageState extends State<AddMember> {
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
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
