import 'package:easyrecord/pages/chart/Line.dart';
import 'package:easyrecord/pages/chart/Pie.dart';
import 'package:flutter/material.dart';

class ChartBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChartBarPageState();
  }
}

class _ChartBarPageState extends State<ChartBarPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
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
            "图表",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          toolbarHeight: 80.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "饼状",
              ),
              Tab(
                text: "条线",
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[PiePage(), LinePage()],
        ));
  }
}
