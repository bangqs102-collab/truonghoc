import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  // Sinh viên
  final List<String> _favoriteSubjectIds = [];
  final List<Map<String, dynamic>> _studentRegisteredClasses = [];

  // Giảng viên
  final List<Map<String, dynamic>> _lecturerTeachingClasses = [];

  List<String> get favoriteSubjectIds => _favoriteSubjectIds;
  List<Map<String, dynamic>> get registeredClasses => _studentRegisteredClasses;
  List<Map<String, dynamic>> get teachingClasses => _lecturerTeachingClasses;

  // Logic Sinh viên
  void toggleFavorite(String subjectId) {
    if (_favoriteSubjectIds.contains(subjectId)) {
      _favoriteSubjectIds.remove(subjectId);
    } else {
      _favoriteSubjectIds.add(subjectId);
    }
    notifyListeners();
  }

  void addStudentClass(Map<String, dynamic> classData) {
    if (!_studentRegisteredClasses.any((item) => item['subjectId'] == classData['subjectId'])) {
      _studentRegisteredClasses.add(classData);
      notifyListeners();
    }
  }

  void removeStudentClass(String subjectId) {
    _studentRegisteredClasses.removeWhere((item) => item['subjectId'] == subjectId);
    notifyListeners();
  }

  // Logic Giảng viên
  void addTeachingClass(Map<String, dynamic> classData) {
    if (!_lecturerTeachingClasses.any((item) => item['subjectId'] == classData['subjectId'] && item['id'] == classData['id'])) {
      _lecturerTeachingClasses.add(classData);
      notifyListeners();
    }
  }

  void removeTeachingClass(String subjectId, String groupId) {
    _lecturerTeachingClasses.removeWhere((item) => item['subjectId'] == subjectId && item['id'] == groupId);
    notifyListeners();
  }
}
