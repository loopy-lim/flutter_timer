// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:study_helper/models/timer_model.dart';
import 'package:study_helper/dao/timer_dao.dart';
import 'package:study_helper/database/timer_db.dart';

class TimerHome extends StatelessWidget {
  List<TimerModel> _timerList = [];
  final OriTimerDAO _timerDao = OriTimerDAO();
  var TimerDuration = const Duration(minutes: 1);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
          middle: const Text('Timer'),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: Get.height / 2,
              child: CupertinoTimerPicker(
                onTimerDurationChanged: (value) {
                  TimerDuration = value;
                },
                mode: CupertinoTimerPickerMode.hm,
                backgroundColor: Colors.white70,
                initialTimerDuration: const Duration(minutes: 1),
              ),
            ),
            SizedBox(height: Get.height / 10),
            CupertinoButton(
                child: const Text("시작"),
                onPressed: () {
                  Get.toNamed('TimerRun', arguments: TimerDuration);
                },
                color: Colors.green[300]),
          ],
        ),
      ),
    );
  }

//이건 나중에 해야 할꺼
  void _addNewTimer(hours, minutes) async {
    //TimerModel newTimer = TimerModel(hours: hours, minutes: minutes);
    //await _timerDao.createTimer(newTimer);
    _loadTimerList();
  }

  void _loadTimerList() async {
    List<TimerModel> newList = await _timerDao.getTimerList();
  }
}
