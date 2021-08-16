// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_helper/controller/timer.dart';

class TimerRun extends StatelessWidget {
  final controller = Get.put(TimerController());
  var timerDuration = Get.arguments as Duration;

  @override
  Widget build(context) {
    controller.initDuration.value = timerDuration;
    controller.curDuration.value = timerDuration;
    controller.startTimer();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('Timer'),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: Get.height / 10,
              child: Obx(
                () => Text(
                  controller.getHms(),
                  style: const TextStyle(
                      color: Colors.black, decoration: TextDecoration.none),
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 2,
              child: Obx(
                () => CustomPaint(
                  painter: BasePainter(
                      controller.initDuration.value.inSeconds.toDouble(),
                      controller.curDuration.value.inSeconds.toDouble()),
                  size: Size(Get.width - 20, Get.height - 20),
                ),
              ),
            ),
            CupertinoButton(
              child: Obx(() =>
                  controller.curDuration.value == const Duration(seconds: 0)
                      ? const Text("완료")
                      : const Text("취소")),
              onPressed: () {
                controller.isOnTimer = false;
                controller.stopTimer();
                Get.offAllNamed('TimerHome');
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class BasePainter extends CustomPainter {
  double timeSeconds = 0;
  double initalSeconds = 0;
  double timeToDegree = 0;

  BasePainter(this.initalSeconds, this.timeSeconds);

  @override
  void paint(Canvas canvas, Size size) {
    timeToDegree = ((initalSeconds - timeSeconds) / initalSeconds) * 360;
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = max(size.width / 2, size.height / 2)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    Paint paint1 = Paint()
      ..color = Colors.red
      ..strokeWidth = max(size.width / 2, size.height / 2)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint1);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2 + 1),
        getRadian(270),
        getRadian(timeToDegree),
        true,
        paint);
  }

  double getRadian(degree) {
    return degree * (pi / 180);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
