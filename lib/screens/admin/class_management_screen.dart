import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'class_students_admin_screen.dart';

class ClassManagementScreen extends StatelessWidget {
  const ClassManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Lớp học')),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: 'LỚP HỌC PHẦN'),
                Tab(text: 'LỚP SINH HOẠT'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildCourseClassList(context),
                  _buildGeneralClassList(context),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCourseClassList(BuildContext context) {
    final List<Map<String, String>> courseClasses = [
      {'name': 'Phát triển di động', 'group': 'Nhóm 01', 'lecturer': 'TS. Lê Văn B', 'count': '45/50'},
      {'name': 'An toàn thông tin', 'group': 'Nhóm 02', 'lecturer': 'ThS. Nguyễn Thị C', 'count': '30/50'},
      {'name': 'Cấu trúc dữ liệu', 'group': 'Nhóm 01', 'lecturer': 'TS. Nguyễn Văn A', 'count': '48/50'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courseClasses.length,
      itemBuilder: (context, index) {
        final item = courseClasses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text('${item['name']} - ${item['group']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('GV: ${item['lecturer']} | Sĩ số: ${item['count']}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassStudentsAdminScreen(className: '${item['name']} (${item['group']})'),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildGeneralClassList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        final className = 'CNTT-K21${String.fromCharCode(65 + index)}';
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text('Lớp $className', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Cố vấn: ThS. Nguyễn Thị C | SV: 50'),
            trailing: const Icon(Icons.groups_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassStudentsAdminScreen(className: className),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
