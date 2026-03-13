import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/app_colors.dart';import '../../../providers/course_provider.dart';

class CourseRegistrationScreen extends StatelessWidget {
  const CourseRegistrationScreen({super.key});

  // Dữ liệu mẫu học phần
  final List<Map<String, dynamic>> _availableSubjects = const [
    {
      'id': 'IT001',
      'name': 'Kỹ thuật lập trình',
      'credits': 3,
      'type': 'Bắt buộc',
      'groups': [
        {'id': 'L01', 'instructor': 'TS. Nguyễn Văn A', 'schedule': 'Thứ 2 (1-3)', 'room': 'A1.202', 'slots': '45/50'},
        {'id': 'L02', 'instructor': 'ThS. Trần Thị B', 'schedule': 'Thứ 3 (4-6)', 'room': 'B2.105', 'slots': '30/50'},
      ]
    },
    {
      'id': 'IT002',
      'name': 'Cấu trúc dữ liệu',
      'credits': 4,
      'type': 'Bắt buộc',
      'groups': [
        {'id': 'L01', 'instructor': 'TS. Lê Văn C', 'schedule': 'Thứ 4 (7-9)', 'room': 'C3.301', 'slots': '48/50'},
      ]
    },
    {
      'id': 'IT003',
      'name': 'Lập trình di động',
      'credits': 3,
      'type': 'Tự chọn',
      'groups': [
        {'id': 'L01', 'instructor': 'ThS. Hoàng Văn D', 'schedule': 'Thứ 6 (1-3)', 'room': 'Lab 01', 'slots': '20/30'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Chỉ lắng nghe Provider tại đây để đảm bảo tính ổn định và hiệu năng
    final courseProvider = context.watch<CourseProvider>();
    final registeredClasses = courseProvider.registeredClasses;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // Màu nền nhạt hiện đại
        appBar: AppBar(
          title: const Text('Đăng ký Học phần', style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'CHỌN MÔN (${_availableSubjects.length})'),
              Tab(text: 'ĐÃ CHỌN (${registeredClasses.length})'),
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

  // --- TAB 1: DANH SÁCH CHỌN MÔN ---
  Widget _buildSelectionTab(BuildContext context, CourseProvider provider) {
    return Column(
      children: [
        // Thanh tìm kiếm nhanh
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchBar(
            hintText: 'Tìm kiếm môn học...',
            leading: const Icon(Icons.search, color: Colors.grey),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _availableSubjects.length,
            itemBuilder: (context, index) {
              final subject = _availableSubjects[index];
              final isAdded = provider.registeredClasses.any((e) => e['subjectId'] == subject['id']);

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: isAdded ? AppColors.primary : Colors.white, width: 2),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: isAdded ? AppColors.primary : Colors.blue.shade50,
                    child: Icon(isAdded ? Icons.check : Icons.book_outlined,
                        color: isAdded ? Colors.white : AppColors.primary, size: 20),
                  ),
                  title: Text(subject['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Mã: ${subject['id']} | ${subject['credits']} Tín chỉ'),
                  children: (subject['groups'] as List).map((group) {
                    return Container(
                      decoration: BoxDecoration(color: Colors.grey.shade50),
                      child: ListTile(
                        title: Text('Nhóm ${group['id']} - ${group['instructor']}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        subtitle: Text('${group['schedule']} | Phòng ${group['room']}'),
                        trailing: ElevatedButton(
                          onPressed: isAdded ? null : () {
                            provider.addStudentClass({
                              'subjectId': subject['id'],
                              'subjectName': subject['name'],
                              'credits': subject['credits'],
                              ...group,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size(70, 36),
                          ),
                          child: const Text('CHỌN', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- TAB 2: DANH SÁCH ĐÃ CHỌN ---
  Widget _buildReviewTab(BuildContext context, CourseProvider provider) {
    final list = provider.registeredClasses;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('Chưa có môn học nào trong danh sách', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(item['subjectName'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Nhóm: ${item['id']} | Lịch: ${item['schedule']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => provider.removeStudentClass(item['subjectId']),
            ),
          ),
        );
      },
    );
  }

  // --- THANH TỔNG KẾT DƯỚI CÙNG ---
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Đã chọn: ${list.length} môn', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Tổng tín chỉ: $total', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.primary)),
              ],
            ),
            ElevatedButton(
              onPressed: list.isEmpty ? null : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã gửi đăng ký thành công!'), backgroundColor: Colors.green, behavior: SnackBarBehavior.floating),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('XÁC NHẬN ĐK', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}