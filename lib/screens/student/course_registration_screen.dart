import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../providers/course_provider.dart';

class CourseRegistrationScreen extends StatelessWidget {
  const CourseRegistrationScreen({super.key});

  final List<Map<String, dynamic>> _availableSubjects = const [
    {
      'id': 'IT001',
      'name': 'Kỹ thuật lập trình',
      'credits': 3,
      'groups': [
        {'id': 'L01', 'instructor': 'TS. Nguyễn Văn A', 'schedule': 'Thứ 2 (1-3)', 'room': 'A1.202'},
        {'id': 'L02', 'instructor': 'ThS. Trần Thị B', 'schedule': 'Thứ 3 (4-6)', 'room': 'B2.105'},
      ]
    },
    {
      'id': 'IT002',
      'name': 'Cấu trúc dữ liệu',
      'credits': 4,
      'groups': [
        {'id': 'L01', 'instructor': 'TS. Lê Văn C', 'schedule': 'Thứ 4 (7-9)', 'room': 'C3.301'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Chỉ gọi Provider 1 lần duy nhất ở gốc hàm build để tránh lỗi render
    final courseProvider = context.watch<CourseProvider>();
    final registeredClasses = courseProvider.registeredClasses;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đăng ký Học phần'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'CHỌN MÔN'),
              Tab(text: 'ĐÃ CHỌN'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSelectionTab(context, courseProvider),
            _buildReviewTab(context, courseProvider),
          ],
        ),
        bottomNavigationBar: _buildBottomSummary(context, registeredClasses),
      ),
    );
  }

  Widget _buildSelectionTab(BuildContext context, CourseProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _availableSubjects.length,
      itemBuilder: (context, index) {
        final subject = _availableSubjects[index];
        final bool isAdded = provider.registeredClasses.any((e) => e['subjectId'] == subject['id']);

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: isAdded ? AppColors.primary : Colors.grey.shade200, width: 2),
          ),
          child: ExpansionTile(
            leading: Icon(isAdded ? Icons.check_circle : Icons.add_circle_outline, color: isAdded ? AppColors.primary : Colors.grey),
            title: Text(subject['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Mã: ${subject['id']} | ${subject['credits']} Tín chỉ'),
            children: (subject['groups'] as List).map((group) {
              return ListTile(
                title: Text('Nhóm ${group['id']} - ${group['instructor']}'),
                subtitle: Text('${group['schedule']} | ${group['room']}'),
                trailing: ElevatedButton(
                  onPressed: isAdded ? null : () {
                    provider.addStudentClass({
                      'subjectId': subject['id'],
                      'subjectName': subject['name'],
                      'credits': subject['credits'],
                      ...group,
                    });
                  },
                  child: const Text('CHỌN'),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildReviewTab(BuildContext context, CourseProvider provider) {
    final list = provider.registeredClasses;
    if (list.isEmpty) return const Center(child: Text('Giỏ hàng trống'));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          child: ListTile(
            title: Text(item['subjectName']),
            subtitle: Text('Nhóm: ${item['id']} | ${item['schedule']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => provider.removeStudentClass(item['subjectId']),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSummary(BuildContext context, List<Map<String, dynamic>> list) {
    int total = list.fold(0, (sum, e) => sum + (e['credits'] as int));
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng tín chỉ: $total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
            ElevatedButton(
              onPressed: list.isEmpty ? null : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gửi đăng ký thành công!'), backgroundColor: Colors.green),
                );
              },
              child: const Text('XÁC NHẬN'),
            ),
          ],
        ),
      ),
    );
  }
}
