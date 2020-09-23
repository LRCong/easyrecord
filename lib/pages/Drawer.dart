import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: UserAccountsDrawerHeader(
                  accountName: Text('李荣聪'),
                  accountEmail: Text('1323794482@qq.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1678948314,1083480950&fm=26&gp=0.jpg"),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage("assets/images/sea1.jpg"),
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.cloud_upload),
            ),
            title: Text("数据备份"),
            onTap: () {},
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.cloud_download),
            ),
            title: Text("数据恢复"),
            onTap: () {},
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.settings),
            ),
            title: Text("密码设置"),
            onTap: () => Navigator.pushNamed(context, '/PwSetting'),
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.account_box),
            ),
            title: Text("账户管理"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
