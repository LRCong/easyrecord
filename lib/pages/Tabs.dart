import 'package:flutter/material.dart';

import 'Drawer.dart';
import 'Home.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  _TabState createState() => _TabState();
}

class _TabState extends State<Tabs> {
  int _page = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("简单记"),
      ),
      body: Home(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Record');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).accentColor,
        shape: CircularNotchedRectangle(),
        elevation: 20.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    onTap(0);
                    Navigator.pushNamed(context, "/Analysis");
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      color: Theme.of(context).cardColor,
                    ),
                    Text("账户",
                        style: TextStyle(color: (Theme.of(context).cardColor)))
                  ],
                ),
              ),
              GestureDetector(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      color: Theme.of(context).cardColor,
                    ),
                    Text("记一笔",
                        style: TextStyle(color: (Theme.of(context).cardColor)))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    onTap(2);
                    Navigator.pushNamed(context, "/Chart");
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.multiline_chart,
                      color: Theme.of(context).cardColor,
                    ),
                    Text("图表",
                        style: TextStyle(color: (Theme.of(context).cardColor)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  void onTap(int value) {
    this._page = value;
  }

  Color getColor(int value) {
    return this._page == value
        ? Theme.of(context).cardColor
        : Color(0XFFBBBBBB);
  }
}
