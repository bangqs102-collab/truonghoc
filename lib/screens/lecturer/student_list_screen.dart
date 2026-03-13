import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentListScreen extends StatelessWidget {
  final String className;
  final String classId;

  const StudentListScreen({super.key, required this.className, required this.classId});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> students = [
      {'id': 'SV001', 'name': 'Nguyễn Văn A', 'email': 'vana@school.edu.vn'},
      {'id': 'SV002', 'name': 'Trần Thị B', 'email': 'thib@school.edu.vn'},
      {'id': 'SV003', 'name': 'Lê Văn C', 'email': 'vanc@school.edu.vn'},
      {'id': 'SV004', 'name': 'Phạm Minh D', 'email': 'dpham@school.edu.vn'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách SV - $classId'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withOpacity(0.05),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  'Tổng số: ${students.length} sinh viên',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Text('${index + 1}', style: const TextStyle(color: AppColors.textPrimary, fontSize: 12)),
                  ),
                  title: Text(student['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('MSSV: ${student['id']} | Email: ${student['email']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.mail_outline, color: AppColors.primary),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
