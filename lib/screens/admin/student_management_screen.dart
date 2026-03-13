import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  // Dữ liệu giả lập danh sách sinh viên
  final List<Map<String, String>> _students = [
    {'id': 'SV001', 'name': 'Nguyễn Văn A', 'class': 'CNTT-K21A', 'email': 'vana@school.edu.vn'},
    {'id': 'SV002', 'name': 'Trần Thị B', 'class': 'CNTT-K21B', 'email': 'thib@school.edu.vn'},
    {'id': 'SV003', 'name': 'Lê Văn C', 'class': 'KT-K22', 'email': 'vanc@school.edu.vn'},
  ];

  void _deleteStudent(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa sinh viên ${_students[index]['name']}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          TextButton(
            onPressed: () {
              setState(() {
                _students.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa sinh viên thành công')),
              );
            },
            child: const Text('XÓA', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Sinh viên'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEditDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm theo tên hoặc MSSV...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(student['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('MSSV: ${student['id']} | Lớp: ${student['class']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showAddEditDialog(student: student, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog({Map<String, String>? student, int? index}) {
    final nameController = TextEditingController(text: student?['name'] ?? '');
    final idController = TextEditingController(text: student?['id'] ?? '');
    final classController = TextEditingController(text: student?['class'] ?? '');
    final emailController = TextEditingController(text: student?['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(student == null ? 'Thêm sinh viên mới' : 'Chỉnh sửa sinh viên'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Họ và tên')),
              const SizedBox(height: 8),
              TextField(controller: idController, decoration: const InputDecoration(labelText: 'MSSV')),
              const SizedBox(height: 8),
              TextField(controller: classController, decoration: const InputDecoration(labelText: 'Lớp')),
              const SizedBox(height: 8),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final newStudent = {
                  'id': idController.text,
                  'name': nameController.text,
                  'class': classController.text,
                  'email': emailController.text,
                };
                if (index == null) {
                  _students.add(newStudent);
                } else {
                  _students[index] = newStudent;
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(index == null ? 'Đã thêm sinh viên mới' : 'Đã cập nhật thông tin')),
              );
            },
            child: const Text('LƯU'),
          ),
        ],
      ),
    );
  }
}
