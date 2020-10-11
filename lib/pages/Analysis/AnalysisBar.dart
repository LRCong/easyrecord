import 'package:flutter/material.dart';

class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnalysisPageState();
  }
}

class _AnalysisPageState extends State<StatefulWidget> {
  @override
  final FirstCatogory = ['【食】品', '【学】习', '【娱】乐'];
  final secondCatogory = ["食堂", '书籍', '玩具'];
  final money = [15, 25, 100];
  final time = ["17:15", '20:19', '22:20'];
  final account = ["微信",'现金','支付宝'];
  final _Font = const TextStyle(fontSize: 18.0);

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('您的记账记录如下')
      ),
      // body: _buildListResult(),
      body: new ListView.builder(
        itemCount: money.length,
        itemBuilder: (context, index){
          return new ListTile(
            leading: new Icon(Icons.done_all),
            title: new Text("${secondCatogory[index]}"),
            subtitle: new Text('${time[index]}·${account[index]}'),
            trailing: new Text("${money[index]}"),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: (){

                },
                child: new Text('时间'),
              ),
            ),
            FlatButton(
              onPressed: (){

              },
              child: new Text('分类'),
            ),
            FlatButton(
              onPressed: (){

              },
              child: new Text('账户'),
            ),
            FlatButton(
              onPressed: (){

              },
              child: new Text('项目'),
            ),
            FlatButton(
              onPressed: (){

              },
              child: new Text('更多'),
            ),
          ],

        ),
      ),
    );
  }

  // Widget _buildListResult() {
  //   return new ListView.builder(
  //       padding: const EdgeInsets.all(16.0),
  //       itemBuilder: (context, i) {
  //         if (i.isOdd) return new Divider();
  //         return _buildRow(_listResult[i~/2]);
  //       });
  // }
  //
  // Widget _buildRow(int res) {
  //   return new ListTile(
  //     title: new Text(
  //       res.toString(),
  //       style: _Font,
  //     ),
  //   );
  // }
}
