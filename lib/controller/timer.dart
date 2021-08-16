import 'package:get/get.dart';
import 'dart:async';

class TimerController extends GetxController {
  var curDuration = const Duration().obs;
  var initDuration = const Duration().obs;
  late var hours = curDuration.value.inHours % 24;
  late var minutes = curDuration.value.inMinutes % 60;
  late var seconds = curDuration.value.inSeconds % 60;
  var initTime = DateTime.now();
  var isOnTimer = false;
  static var timer = Timer.periodic(const Duration(seconds: 0), (time) {});

  String getHm() => "$hours:$minutes";
  String getMs() => "$minutes:$seconds";
  String getHms() => hours != 0 ? getHm() : getMs();

  void startTimer() {
    isOnTimer = true;
    timer = Timer.periodic(const Duration(seconds: 1), (time) {
      if (--seconds < 0) {
        minutes -= 1;
        seconds = 60;
      }
      if (minutes < 0) {
        if (hours > 0) hours -= 1;
      }
      curDuration.value =
          Duration(hours: hours, minutes: minutes, seconds: seconds);
      if (hours == 0 && minutes == 0 && seconds == 0) {
        isOnTimer = false;
        stopTimer();
      }
    });
  }

  void stopTimer() {
    isOnTimer = false;
    timer.cancel();
  }
}
