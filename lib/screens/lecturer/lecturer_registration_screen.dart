import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../providers/course_provider.dart';

class LecturerRegistrationScreen extends StatefulWidget {
  const LecturerRegistrationScreen({super.key});

  @override
  State<LecturerRegistrationScreen> createState() => _LecturerRegistrationScreenState();
}

class _LecturerRegistrationScreenState extends State<LecturerRegistrationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _availableToTeach = [
    {
      'id': 'IT001',
      'name': 'Kỹ thuật lập trình',
      'credits': 3,
      'groups': [
        {'id': 'L01', 'schedule': 'Thứ 2 (1-3)', 'room': 'A1.202', 'status': 'Chưa có GV'},
        {'id': 'L02', 'schedule': 'Thứ 3 (4-6)', 'room': 'B2.105', 'status': 'Chưa có GV'},
      ]
    },
    {
      'id': 'IT002',
      'name': 'Cấu trúc dữ liệu',
      'credits': 4,
      'groups': [
        {'id': 'L01', 'schedule': 'Thứ 4 (7-9)', 'room': 'C3.301', 'status': 'Chưa có GV'},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _registerToTeach(Map<String, dynamic> subject, Map<String, dynamic> group) {
    context.read<CourseProvider>().addTeachingClass({
      'subjectId': subject['id'],
      'subjectName': subject['name'],
      'credits': subject['credits'],
      ...group,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã gửi yêu cầu nhận dạy môn ${subject['name']}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teachingClasses = context.watch<CourseProvider>().teachingClasses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký Giảng dạy'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'LỚP CẦN GV (${_availableToTeach.length})'),
            Tab(text: 'LỚP ĐÃ ĐĂNG KÝ (${teachingClasses.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAvailableTab(teachingClasses),
          _buildMyTeachingTab(teachingClasses),
        ],
      ),
    );
  }

  Widget _buildAvailableTab(List<Map<String, dynamic>> registered) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _availableToTeach.length,
      itemBuilder: (context, index) {
        final subject = _availableToTeach[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: Text(subject['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${subject['id']} | ${subject['credits']} Tín chỉ'),
            children: (subject['groups'] as List).map((group) {
              bool isRegistered = registered.any((r) => r['subjectId'] == subject['id'] && r['id'] == group['id']);
              return ListTile(
                title: Text('Nhóm ${group['id']} - ${group['schedule']}'),
                subtitle: Text('Phòng: ${group['room']} | ${group['status']}'),
                trailing: ElevatedButton(
                  onPressed: isRegistered ? null : () => _registerToTeach(subject, group),
                  child: Text(isRegistered ? 'ĐÃ ĐK' : 'ĐĂNG KÝ'),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMyTeachingTab(List<Map<String, dynamic>> registered) {
    if (registered.isEmpty) return const Center(child: Text('Bạn chưa đăng ký dạy lớp nào'));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: registered.length,
      itemBuilder: (context, index) {
        final item = registered[index];
        return Card(
          child: ListTile(
            title: Text(item['subjectName']),
            subtitle: Text('Nhóm: ${item['id']} | Lịch: ${item['schedule']}'),
            trailing: TextButton(
              onPressed: () => context.read<CourseProvider>().removeTeachingClass(item['subjectId'], item['id']),
              child: const Text('HỦY', style: TextStyle(color: Colors.red)),
            ),
          ),
        );
      },
    );
  }
}
