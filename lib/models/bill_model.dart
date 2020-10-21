import 'package:flutter/material.dart';

final String columnId = 'id';
final String columnCost = 'cost';
final String columnMainType = 'mainType';
final String columnSubType = 'subType';
final String columnType = 'type';
final String columnAccount = "account";
final String columnMember = "member";
final String columnCreateTimeStamp = 'createTimeStamp';

final String columnsort = 'sort';
final String columnInAccount = 'inAccount';
final String columnoutAccount = 'outAccount';

//账户
class Item {
  int id; //唯一识别主键
  num cost; //金额
  String mainType; //一级类型
  String subType; //二级类型
  int type; //{1:"支出",2:"收入"3:"转帐",}
  String account; //账户
  String member; //成员
  int createTimeStamp; //创建的时间戳
  String inAccount; //转入账户
  String outAccount; //转出账户

  Item(
      {this.id,
      this.cost,
      this.mainType,
      this.subType,
      this.type,
      this.account,
      this.member,
      this.createTimeStamp,
      this.inAccount,
      this.outAccount});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCost: cost,
      columnMainType: mainType,
      columnSubType: subType,
      columnType: type,
      columnAccount: account,
      columnMember: member,
      columnCreateTimeStamp: createTimeStamp,
      columnInAccount: inAccount,
      columnoutAccount: outAccount
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
    inAccount = map[columnInAccount];
    outAccount = map[columnoutAccount];
  }
}

//目录
class outcomeCategory {
  String mainType;
  String subType;
  int sort;

  outcomeCategory({this.mainType, this.subType, this.sort});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMainType: mainType,
      columnSubType: subType,
      columnsort: sort
    };
    return map;
  }

  outcomeCategory.fromMap(Map<String, dynamic> map) {
    mainType = map[columnMainType];
    subType = map[columnSubType];
    sort = map[columnsort];
  }
}

//目录
class incomeCategory {
  String mainType;
  String subType;
  int sort;

  incomeCategory({this.mainType, this.sort});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMainType: mainType,
      columnSubType: subType,
      columnsort: sort
    };
    return map;
  }

  incomeCategory.fromMap(Map<String, dynamic> map) {
    mainType = map[columnMainType];
    subType = map[columnSubType];
    sort = map[columnsort];
  }
}

//目录
class accountCategory {
  String account;
  int sort;

  accountCategory({this.account, this.sort});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnAccount: account, columnsort: sort};
    return map;
  }

  accountCategory.fromMap(Map<String, dynamic> map) {
    account = map[columnAccount];
    sort = map[columnsort];
  }
}

//目录
class memberCategory {
  String member;
  int sort;

  memberCategory({this.member, this.sort});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnMember: member, columnsort: sort};
    return map;
  }

  memberCategory.fromMap(Map<String, dynamic> map) {
    member = map[columnMember];
    sort = map[columnsort];
  }
}
