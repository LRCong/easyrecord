import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableItem = 'item';
final String columnCost = 'cost';
final String columnId = '_id';
final String columnMainType = 'mainType';
final String columnSubType = 'subType';
final String columnType = 'type';
final String columnNote = 'note';
final String columnAccount = "account";
final String columnMember = "member";
final String columnSubject = 'subject';

class Item {
  int id; //唯一识别主键
  num cost; //金额
  String mainType; //一级类型
  String subType; //二级类型
  int type; //{1:"收入",2:"支出"3:"转入",4:"转出",}
  String note; //备注
  String account; //账户
  String member; //成员
  String subject; //项目

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCost: cost,
      columnMainType: mainType,
      columnSubType: subType,
      columnType: type,
      columnNote: note,
      columnAccount: account,
      columnMember: member,
      columnSubject: subject
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Item();

  Item.fromMap(Map<String, dynamic> map) {
    cost = map[columnCost];
    mainType = map[columnType];
    subType = map[columnType];
    type = map[columnType];
    note = map[columnNote];
    id = map[columnId];
    account = map[columnAccount];
    member = map[columnMember];
    subject = map[columnSubject];
  }
}

class ItemProvider {
  Database db;
}
