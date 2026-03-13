import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LecturerManagementScreen extends StatefulWidget {
  const LecturerManagementScreen({super.key});

  @override
  State<LecturerManagementScreen> createState() => _LecturerManagementScreenState();
}

class _LecturerManagementScreenState extends State<LecturerManagementScreen> {
  final List<Map<String, String>> _lecturers = [
    {'id': 'GV001', 'name': 'TS. Nguyễn Văn A', 'department': 'Công nghệ thông tin', 'email': 'a.nguyen@school.edu.vn'},
    {'id': 'GV002', 'name': 'ThS. Trần Thị B', 'department': 'Kinh tế', 'email': 'b.tran@school.edu.vn'},
  ];

  void _deleteLecturer(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa giảng viên ${_lecturers[index]['name']}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          TextButton(
            onPressed: () {
              setState(() => _lecturers.removeAt(index));
              Navigator.pop(context);
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
        title: const Text('Quản lý Giảng viên'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => _showAddEditDialog()),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lecturers.length,
        itemBuilder: (context, index) {
          final lecturer = _lecturers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.secondary,
                child: Icon(Icons.supervisor_account, color: Colors.white),
              ),
              title: Text(lecturer['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('ID: ${lecturer['id']} | Khoa: ${lecturer['department']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showAddEditDialog(lecturer: lecturer, index: index)),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteLecturer(index)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddEditDialog({Map<String, String>? lecturer, int? index}) {
    final nameController = TextEditingController(text: lecturer?['name'] ?? '');
    final idController = TextEditingController(text: lecturer?['id'] ?? '');
    final deptController = TextEditingController(text: lecturer?['department'] ?? '');
    final emailController = TextEditingController(text: lecturer?['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lecturer == null ? 'Thêm giảng viên' : 'Sửa giảng viên'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Họ và tên')),
              TextField(controller: idController, decoration: const InputDecoration(labelText: 'Mã GV')),
              TextField(controller: deptController, decoration: const InputDecoration(labelText: 'Khoa')),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final data = {'id': idController.text, 'name': nameController.text, 'department': deptController.text, 'email': emailController.text};
                if (index == null) _lecturers.add(data); else _lecturers[index] = data;
              });
              Navigator.pop(context);
            },
            child: const Text('LƯU'),
          ),
        ],
      ),
    );
  }
}
