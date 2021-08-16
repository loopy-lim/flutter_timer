import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './timer/timer_home.dart';
import 'package:study_helper/timer/timer_run.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/TimerHome',
      getPages: [
        GetPage(name: '/TimerHome', page: () => TimerHome()),
        GetPage(
            name: '/TimerRun',
            page: () => TimerRun(),
            transition: Transition.leftToRightWithFade),
      ],
    ),
  );
}
