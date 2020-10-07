import 'package:local_auth/local_auth.dart';

import 'package:flutter/material.dart';

class FingerPwRecognitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FingerPwRecognitionPageState();
  }
}

class _FingerPwRecognitionPageState extends State<FingerPwRecognitionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("字符密码"), automaticallyImplyLeading: false),
        body: WillPopScope(
          child: Text(""),
          onWillPop: () async {
            return false;
          },
        ));
  }
}
