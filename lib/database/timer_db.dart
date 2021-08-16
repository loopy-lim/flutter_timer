import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const oriTimerTable = "ori_timer_table";

class DatabaseProvier {
  static final DatabaseProvier provier = DatabaseProvier();
  late Database _database;

  Future<Database> get database async {
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, "todo.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {
      //Todo :: Migration
    }
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $oriTimerTable ("
        "id STRING PRIMARY KEY, "
        "hours INTEGER"
        "minutes INTEGER"
        ")");
  }
}
