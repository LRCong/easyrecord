import 'package:flutter/material.dart';

import 'Pay.dart';
import 'package:easyrecord/pages/record/Income.dart';
import 'package:easyrecord/pages/record/Transfer.dart';

class RecordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecordPageState();
  }
}

class _RecordPageState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "记一笔",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "支出",
              ),
              Tab(
                text: "收入",
              ),
              Tab(
                text: "转账",
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PayPage(),
            IncomePage(),
            TransferPage(),
          ],
        ));
  }
}
