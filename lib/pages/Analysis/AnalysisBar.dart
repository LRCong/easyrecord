import 'package:flutter/material.dart';
import '../record/jh_picker_tool.dart';
class AnalysisPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnalysisPageState();
  }
}

class _AnalysisPageState extends State<StatefulWidget> {
  @override
  int _enableType = 0;       //0:时间，1：分类， 2：账户， 3：项目， 4：更多
  String time = '月';
  String category = '一级分类';
  String more = '成员';



  final FirstCatogory = ['【食】品', '【学】习', '【娱】乐'];
  final secondCatogory = ["食堂", '书籍', '玩具'];
  final money = [15, 25, 100];
  final testTime = ["17:15", '20:19', '22:20'];
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
            subtitle: new Text('${testTime[index]}·${account[index]}'),
            trailing: new Text("${money[index]}"),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              // setstate()
              child: FlatButton(
                onPressed: (){
                    JhPickerTool.showStringPicker(context,
                        data: timeTypes,
                        normalIndex: 0,
                        title: "请选择时间范围",
                        clickCallBack: (int index, var str) {
                        setState(() {
                          print(index);
                          _enableType = 0;
                          time = str;
                          print("time select is $time");
                          // refreshState();
                        });
                      });

                },
                child: new Text('时间', style: TextStyle(
                  color:_enableType==0?Colors.yellow[800]:Colors.black,
                )
                  ),
              ),
            ),
            FlatButton(
              onPressed: (){
                JhPickerTool.showStringPicker(context,
                    data: categoryTypes,
                    normalIndex: 0,
                    title: "请选择分类", clickCallBack: (int index, var str) {
                      setState(() {
                        print(index);
                        _enableType = 1;
                        category = str;
                        print("time select is $category");
                      });
                      // refreshState();
                    });
              },
              child: new Text('分类', style: TextStyle(
                color:_enableType==1?Colors.yellow[800]:Colors.black,
              )),
            ),
            FlatButton(
              onPressed: (){
                setState(() {
                  _enableType = 2;
                });
              },
              child: new Text('账户', style: TextStyle(
                color:_enableType==2?Colors.yellow[800]:Colors.black,
              )),
            ),
            FlatButton(
              onPressed: (){
                setState(() {
                  _enableType = 3;
                });

              },
              child: new Text('项目', style: TextStyle(
                color:_enableType==3?Colors.yellow[800]:Colors.black,
              )),
            ),
            FlatButton(
              onPressed: (){
                JhPickerTool.showStringPicker(context,
                    data: moreTypes,
                    normalIndex: 0,
                    title: "请选择更多筛选条件", clickCallBack: (int index, var str) {
                      setState(() {
                        print(index);
                        _enableType = 4;
                        more = str;
                        print("time select is $more");
                        // refreshState();
                      });
                    });
              },
              child: new Text('更多', style: TextStyle(
                color:_enableType==4?Colors.yellow[800]:Colors.black,
              )),
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

var timeTypes = [
  "年",
  "季",
  "月",
  "周",
  "天",
  "时",
];

var categoryTypes = [
  "一级分类",
  "二级分类",
];

var moreTypes = [
  "成员",
  "商家",
];