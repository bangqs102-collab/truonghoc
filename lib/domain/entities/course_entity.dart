class CourseEntity {
  final String id;
  final String name;
  final int credits;
  final String type; // Bắt buộc / Tự chọn
  final List<CourseGroupEntity> groups;

  CourseEntity({
    required this.id,
    required this.name,
    required this.credits,
    required this.type,
    required this.groups,
  });
}

class CourseGroupEntity {
  final String groupId;
  final String instructorName;
  final String schedule; // Ví dụ: Thứ 2 (1-3)
  final String room;
  final int maxSlots;
  final int currentSlots;

  CourseGroupEntity({
    required this.groupId,
    required this.instructorName,
    required this.schedule,
    required this.room,
    required this.maxSlots,
    required this.currentSlots,
  });
}
