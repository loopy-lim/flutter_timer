class TimerModel {
  int id;
  DateTime time;
  Duration duration;

  TimerModel({
    required this.time,
    required this.duration,
    this.id = 0,
  });

  factory TimerModel.fromDatabaseJson(Map<String, dynamic> data) => TimerModel(
      time: data['hours'], duration: data['duration'], id: data['id']);
  Map<String, dynamic> toDatabaseJson() =>
      {'time': time, 'minutes': duration, 'id': id};
}
