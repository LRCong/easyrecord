import 'package:easyrecord/pages/record/AddMainType.dart';
import 'package:easyrecord/pages/record/AddMember.dart';
import 'package:easyrecord/pages/record/AddSubType.dart';
import 'package:easyrecord/pages/record/addAccount.dart';
import 'package:flutter/material.dart';

class RecordSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecordSettingState();
  }
}

class _RecordSettingState extends State<RecordSettingPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
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
            "添加可选项",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "账户",
              ),
              Tab(
                text: "大类",
              ),
              Tab(
                text: "小类",
              ),
              Tab(
                text: "成员",
              )
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            AddAccountPage(),
            AddMainTypePage(),
            AddSubTypePage(),
            AddMember()
          ],
        ));
  }
}
