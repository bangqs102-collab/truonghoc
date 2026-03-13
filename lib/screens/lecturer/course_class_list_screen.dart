import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'student_list_screen.dart';

class CourseClassListScreen extends StatelessWidget {
  const CourseClassListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> classes = [
      {'id': 'IT001.L01', 'name': 'Kỹ thuật lập trình', 'students': 45, 'room': 'A1.202'},
      {'id': 'IT002.L02', 'name': 'Cấu trúc dữ liệu', 'students': 38, 'room': 'B2.105'},
      {'id': 'IT003.L01', 'name': 'Lập trình di động', 'students': 30, 'room': 'Lab 01'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lớp học phần phụ trách')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final item = classes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.class_outlined, color: Colors.white),
              ),
              title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Mã lớp: ${item['id']} | Phòng: ${item['room']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people_outline, size: 20),
                  Text('${item['students']} SV', style: const TextStyle(fontSize: 12)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentListScreen(className: item['name'], classId: item['id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
