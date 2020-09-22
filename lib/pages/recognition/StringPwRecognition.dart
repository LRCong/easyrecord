import 'package:flutter/material.dart';
import 'PwControllor.dart';

class StringPwRecognitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StringPwRecognitionPageState();
  }
}

class _StringPwRecognitionPageState extends State<StringPwRecognitionPage> {
  var _stringPw = new TextEditingController();
  var _string;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringPw().then((value) {
      _string = value ?? 000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("字符密码"), automaticallyImplyLeading: false),
        body: WillPopScope(
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150.0,
                color: Colors.blue[400],
                child: Stack(
                  overflow: Overflow.visible, // 超出部分显示
                  children: <Widget>[
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 90) / 2.0,
                      top: 150.0 - 45,
                      child: Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          ///阴影
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).cardColor,
                                blurRadius: 4.0)
                          ],

                          ///形状
                          shape: BoxShape.circle,

                          ///图片
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: ExactAssetImage("assets/images/sea1.jpg"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "密码"),
                      controller: _stringPw,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: MaterialButton(
                        child: Text("输入字符密码"),
                        onPressed: () {
                          if (_string == _stringPw.text) {
                            print(_string);
                            print(_stringPw.text);
                            Navigator.of(context).pop(true);
                          } else {
                            print(_string);
                            print(_stringPw.text);
                            print("错误");
                            setState(() {});
                          }
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          onWillPop: () async {
            return false;
          },
        ));
  }
}
