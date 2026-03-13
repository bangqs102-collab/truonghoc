class Schedule {
  final String subjectName;
  final String room;
  final DateTime startTime;
  final DateTime endTime;
  final String instructor;

  Schedule({
    required this.subjectName,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.instructor,
  });
}
