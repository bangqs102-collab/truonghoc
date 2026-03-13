import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ClassDetailScreen extends StatelessWidget {
  final String className;
  const ClassDetailScreen({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết lớp học')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(className, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  const Text('Mã HP: IT001 | Số tín chỉ: 3', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Thông tin giảng dạy'),
            _infoRow(Icons.person, 'Giảng viên', 'TS. Nguyễn Văn A'),
            _infoRow(Icons.email, 'Email', 'a.nguyen@school.edu.vn'),
            _infoRow(Icons.calendar_month, 'Lịch học', 'Thứ 2 (1-3), Thứ 4 (4-6)'),
            _infoRow(Icons.location_on, 'Phòng học', 'A1.202'),
            const Divider(height: 40),
            _buildSectionTitle('Mô tả môn học'),
            const Text(
              'Môn học cung cấp các kiến thức cơ bản về kỹ thuật lập trình, các cấu trúc điều khiển, mảng, chuỗi, con trỏ và cách tổ chức chương trình hiệu quả.',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
