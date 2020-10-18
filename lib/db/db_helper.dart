import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/bill_model.dart';

var dbHelp = new Dbhelper();

class Dbhelper {
  Dbhelper._internal();

  static Dbhelper _singleton = new Dbhelper._internal();

  factory Dbhelper() => _singleton;

  Database _db;

  /// 账单表
  final _billTableName = 'BillRecord';

  //类型表
  final _incomeCategory = 'incomeCategory';

  final _outcomeCategory = 'outcomeCategory';

  final _accountCategory = 'accountCategory';

  final _memberCategory = 'memberCategory';

  /// 获取数据库
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  _initDb() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = join(document.path, 'AccountDb', 'Account.db');
    debugPrint(path);

    // Delete the database
    await deleteDatabase(path);
    var db = await openDatabase(path, version: 3, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // 账单记录表
    //id  cost金额 mainType一级类型 subType二级类型   type1:"收入"2:"支出"3转入"4"转出"
    //account账户 member成员  createTimeStamp创建的时间戳
    String queryBill = """
    CREATE TABLE $_billTableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      cost REAL NOT NULL,
      mainType TEXT NOT NULL,
      subType TEXT NOT NULL,
      type INTEGER DEFAULT(1),
      account TEXT,
      member TEXT,
      createTimeStamp INTEGER,
      inAccount TEXT,
      outAccount TEXT
    )
    """;
    await db.execute(queryBill);
    //建立支出类别表
    String queryStringCategory = """
    CREATE TABLE $_outcomeCategory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      mainType TEXT,
      subType TEXT,
      sort INTEGER
    )
    """;
    await db.execute(queryStringCategory);

    //建立收入类别表
    String queryStringCategory2 = """
    CREATE TABLE $_incomeCategory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      mainType TEXT,
      subType TEXT,
      sort INTEGER
    )
    """;
    await db.execute(queryStringCategory2);

    //建立账户类别表
    String queryStringCategory3 = """
    CREATE TABLE $_accountCategory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      account TEXT,
      sort INTEGER
    )
    """;
    await db.execute(queryStringCategory3);

    //建立成员类别表
    String queryStringCategory4 = """
    CREATE TABLE $_memberCategory(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      member TEXT,
      sort INTEGER
    )
    """;
    await db.execute(queryStringCategory4);

    // 初始化支出类别表数据
    rootBundle.loadString('assets/data/outcomeCategory.json').then((value) {
      List list = jsonDecode(value);
      List<outcomeCategory> models =
          list.map((i) => outcomeCategory.fromMap(i)).toList();
      models.forEach((item) async {
        await db.insert(_outcomeCategory, item.toMap());
      });
    });

    // 初始化收入类别表数据
    rootBundle.loadString('assets/data/incomeCategory.json').then((value) {
      List list = jsonDecode(value);
      List<incomeCategory> models =
          list.map((i) => incomeCategory.fromMap(i)).toList();
      models.forEach((item) async {
        await db.insert(_incomeCategory, item.toMap());
      });
    });

    // 初始化账户类别表数据
    rootBundle.loadString('assets/data/account.json').then((value) {
      List list = jsonDecode(value);
      List<accountCategory> models =
          list.map((i) => accountCategory.fromMap(i)).toList();
      models.forEach((item) async {
        await db.insert(_accountCategory, item.toMap());
      });
    });

    // 初始化成员类别表数据
    rootBundle.loadString('assets/data/member.json').then((value) {
      List list = jsonDecode(value);
      List<memberCategory> models =
          list.map((i) => memberCategory.fromMap(i)).toList();
      models.forEach((item) async {
        await db.insert(_memberCategory, item.toMap());
      });
    });
  }

  /// 获取记账支出类别列表
  /*
  传参：无

  返回：List<MAP<String, dynamic>>   每个MAP为一个目录类型包含mainType（一级目录）
  subType（二级目录） sort（序号）  具体可见Category类的相关信息
  
  调用示例：
    dbHelp.getOutcomeCategory().then((list) {
                        print(list.length);
                        for (int i = 0; i < list.length; i++) {
                          Map map = list[i];
                          print(map["mainType"]);   
                          print(map["subType"]);
                          print(map["sort"]);
                        }
                      });
  */
  Future<List> getOutcomeCategory() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM $_outcomeCategory ORDER BY sort ASC');
    return result.toList();
  }

  Future<List> getIncomeCategory() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM $_incomeCategory ORDER BY sort ASC');
    return result.toList();
  }

  Future<List> getAccountCategory() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM $_accountCategory ORDER BY sort ASC');
    return result.toList();
  }

  Future<List> getMemberCategory() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM $_memberCategory ORDER BY sort ASC');
    return result.toList();
  }

  /*插入或更新账单

  传参：Item  一个账单类

  返回： int id  插入的账单数据库分配的id 

  调用示例：
        Item item = Item(
                        id: null,    //注意 插入新账单id需为null， 若传入id则此操作为更新表中对应id的账单
                        cost: 7.5,
                        mainType: "sports",
                        subType: "basketball",
                        type: 1,
                        account: "banket",
                        member: "father",
                        createTimeStamp: DateTime.now().millisecondsSinceEpoch);   
      
        dbHelp.insertItem(item).then((value) => print(value));  //返回值（即value）为最后插入的账单数据库分配的id， 
  */
  Future<int> insertItem(Item item) async {
    var dbClient = await db; //

    var map = item.toMap();

    var result;
    /*print(map['cost']);
    print(map['member']);*/
    try {
      if (item.id == null) {
        result = await dbClient.insert(_billTableName, map);
      } else {
        result = await dbClient.update(_billTableName, map,
            where: 'id == ${item.id}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  /*
   insertCategory调用示例：
          dbHelp
              .insertCategory("收入", "cg！", "yyds!")
              .then((value) => print(value));

          dbHelp
              .insertCategory("支出", "yyds!", "cg!")
              .then((value) => print(value));
  */
  //type 为“收入”时添加收入类别， 为“支出”时添加支出类别
  Future<int> insertCategory(
      String type, String mainType, String subType) async {
    var dbClient = await db; //

    //var map = item.toMap();

    var result;
    /*print(map['cost']);
    print(map['member']);*/
    try {
      if (type == "收入") {
        var sortIncome = Sqflite.firstIntValue(
            await dbClient.rawQuery('SELECT COUNT(*) FROM $_incomeCategory'));
        var map = {
          "mainType": mainType,
          "subType": subType,
          "sort": sortIncome
        };
        sortIncome++;
        result = await dbClient.insert(_incomeCategory, map);
      } else if (type == "支出") {
        var sortOutcome = Sqflite.firstIntValue(
            await dbClient.rawQuery('SELECT COUNT(*) FROM $_outcomeCategory'));
        var map = {
          "mainType": mainType,
          "subType": subType,
          "sort": sortOutcome
        };
        result = await dbClient.insert(_outcomeCategory, map);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  //插入自定义成员
  Future<int> insertMember(String member) async {
    var dbClient = await db; //
    var result;
    try {
      var sortMember = Sqflite.firstIntValue(
          await dbClient.rawQuery('SELECT COUNT(*) FROM $_memberCategory'));
      var map = {"member": member, "sort": sortMember};
      result = await dbClient.insert(_memberCategory, map);
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  //插入自定义账户
  Future<int> insertAccount(String account) async {
    var dbClient = await db; //
    var result;
    try {
      var sortAccount = Sqflite.firstIntValue(
          await dbClient.rawQuery('SELECT COUNT(*) FROM $_accountCategory'));
      var map = {"account": account, "sort": sortAccount};
      result = await dbClient.insert(_accountCategory, map);
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  /// 查询账单
  /*
    传参： 见下面的注释

    返回：List<Map<String, dynamic>>   每个MAP为一个账单
    包含 id（数据库中的id） cost（金额) mainType(一级目录) subType(二级目录)
    type（类型）  account（账户） member（成员）  createTimeStamp（创建的时间戳）具体可以Item类的相关信息

    调用示例（以获取某个成员某个时间段的账单为例）：
    dbHelp
        .getAcount(
            startTime: 0,
            endTime: 1701125919708,
            member: 'father')
        .then((value) {
      print(value.length);
      for (int i = 0; i < value.length; i++) {
        Item tmp = Item.fromMap(value[i]);
        print(tmp.id);
        print(tmp.cost);
        print(tmp.createTimeStamp);
      }
    });
  */
  //起止时间  账户  成员 均为可选命名参数
  //获取全部账单： 不传参
  //获取某个成员全部账单：  只传成员
  //获取某个账户全部账单：  只传账户
  //获取某个成员某个时间段内账单： 传入成员和起止时间
  //获取某个账户某个时间段内账单： 传入账户和起止时间
  //返回值：List里放MAP 每个MAP就是一个账单    以账单创建时间升序排序
  Future<List<Map<String, dynamic>>> getAcount(
      {int startTime, int endTime, String member, String account}) async {
    var dbClient = await db;
    var result;
    print("开始查账！");
    if (member != null && account != null) {
      print("目前不能同时传成员和账户!");
      return null;
    } else if (member != null && startTime != null && endTime != null) {
      print("获取某个成员某个时间段内账单");
      result = await dbClient.rawQuery(
          'SELECT * FROM $_billTableName WHERE member = "$member" and createTimeStamp >= $startTime and createTimeStamp <= $endTime ORDER BY createTimeStamp ASC');
    } else if (account != null && startTime != null && endTime != null) {
      print("获取某个账户某个时间段内账单");
      result = await dbClient.rawQuery(
          'SELECT * FROM $_billTableName WHERE  account = "$account" and createTimeStamp >= $startTime and createTimeStamp <= $endTime ORDER BY createTimeStamp ASC');
    } else if (member != null && startTime == null && endTime == null) {
      print("获取某个成员全部账单");
      result = await dbClient.rawQuery(
          'SELECT * FROM $_billTableName WHERE member = "$member" ORDER BY createTimeStamp ASC');
    } else if (account != null && startTime == null && endTime == null) {
      print("获取某个账户全部账单");
      result = await dbClient.rawQuery(
          'SELECT * FROM $_billTableName WHERE account = "$account" ORDER BY createTimeStamp ASC');
    } else if (member == null &&
        account == null &&
        startTime != null &&
        endTime != null) {
      print("获取某个时间段全部账单");
      result = await dbClient.rawQuery(
          'SELECT * FROM $_billTableName WHERE createTimeStamp >= $startTime and createTimeStamp <= $endTime ORDER BY createTimeStamp ASC');
    }
    var list = result.toList();
    if (list.length > 0) {
      return list;
    } else {
      return null;
    }
  }

//调用示例：
//dbHelp.deleteAccount(1); 删除id为1的账单
  void deleteAccount(int id) async {
    var dbClient = await db; //

    await dbClient.rawDelete('DELETE FROM $_billTableName WHERE id = ?', [id]);

    try {} catch (e) {
      debugPrint(e.toString());
    }
  }
}
