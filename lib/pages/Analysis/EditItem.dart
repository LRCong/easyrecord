import 'package:easyrecord/models/bill_model.dart';
import 'package:flutter/material.dart';
import 'EditIncome.dart';
import 'EditPay.dart';

import 'EditTransfer.dart';

class EditItemPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditItemState();
  }
}

class _EditItemState extends State<StatefulWidget>{
  Item _item;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _item = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "编辑"+
                (_item.type==1?'支出':(_item.type==2?"收入":'转账')),
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          // toolbarHeight: 80.0,
        ),
        body: (_item.type==1?EditPayPage(_item):(_item.type==2?EditIncomePage(_item):EditTransferPage(_item))),
        );
  }

}
