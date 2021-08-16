import 'dart:async';
import '../database/ori_timer_db.dart';
import '../models/timer_model.dart';

class OriTimerDAO {
  final dbProvider = DatabaseProvier.provier;

  Future<int> createTimer(TimerModel timer) async {
    final db = await dbProvider.database;
    final result = db.insert(oriTimerTable, timer.toDatabaseJson());
    return result;
  }

  Future<List<TimerModel>> getTimerList() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = await db.query(oriTimerTable);
    List<TimerModel> timerList = result.isNotEmpty
        ? result.map((item) => TimerModel.fromDatabaseJson(item)).toList()
        : [];
    return timerList;
  }
}
