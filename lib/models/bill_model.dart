import 'package:flutter/material.dart';

final String columnId = '_id';
final String columnCost = 'cost';
final String columnMainType = 'mainType';
final String columnSubType = 'subType';
final String columnType = 'type';
final String columnAccount = "account";
final String columnMember = "member";
final String columnCreateTimeStamp = 'createTimeStamp';

final String columnsort = 'sort';

//账户
class Item {
  int id; //唯一识别主键
  num cost; //金额
  String mainType; //一级类型
  String subType; //二级类型
  int type; //{1:"收入",2:"支出"3:"转入",4:"转出",}
  String account; //账户
  String member; //成员
  int createTimeStamp; //创建的时间戳

  Item(
      {this.id,
      this.cost,
      this.mainType,
      this.subType,
      this.type,
      this.account,
      this.member,
      this.createTimeStamp});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCost: cost,
      columnMainType: mainType,
      columnSubType: subType,
      columnType: type,
      columnAccount: account,
      columnMember: member,
      columnCreateTimeStamp: createTimeStamp
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    cost = map[columnCost];
    mainType = map[columnMainType];
    subType = map[columnSubType];
    type = map[columnType];
    account = map[columnAccount];
    member = map[columnMember];
    createTimeStamp = map[columnCreateTimeStamp];
  }
}

//目录
class Category {
  String mainType;
  String subType;
  int type;
  int sort;

  Category({this.mainType, this.subType, this.type, this.sort});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMainType: mainType,
      columnSubType: subType,
      columnType: type,
      columnsort: sort
    };
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    mainType = map[columnMainType];
    subType = map[columnSubType];
    sort = map[columnsort];
    type = map[columnType];
  }
}
