class ScheduleEntity {
  final String id;
  final String courseName;
  final String className;
  final String instructorName;
  final String dayOfWeek;
  final String timeSlot;
  final String room;

  ScheduleEntity({
    required this.id,
    required this.courseName,
    required this.className,
    required this.instructorName,
    required this.dayOfWeek,
    required this.timeSlot,
    required this.room,
  });
}
