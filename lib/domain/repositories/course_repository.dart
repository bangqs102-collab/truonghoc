import '../entities/course_entity.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getAvailableCourses();
  Future<bool> registerCourse(String studentId, String courseId, String groupId);
  Future<List<CourseEntity>> getStudentRegisteredCourses(String studentId);
  Future<bool> cancelRegistration(String studentId, String courseId);
}
