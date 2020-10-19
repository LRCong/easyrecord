import 'package:flutter/material.dart';

class EditItemPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditItemState();
  }
}

class _EditItemState extends State<StatefulWidget>{
  int _pressedTimes = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("修改记录"),
      ),
        body:Center(
          child: InkWell(
            onTap: (){
              setState(() {
                _pressedTimes++;
                if(_pressedTimes > 5)
                  Navigator.pop(context);
              });
            },
            child: Text("你按下我了$_pressedTimes次"),
          ),
        )
    );
  }

}
