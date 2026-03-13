class Student {
  final String id;
  final String name;
  final String email;
  final String major;
  final String avatarUrl;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.major,
    this.avatarUrl = '',
  });
}
