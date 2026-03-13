class Subject {
  final String code;
  final String name;
  final double credits;
  final double? grade;

  Subject({
    required this.code,
    required this.name,
    required this.credits,
    this.grade,
  });
}
