import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AcademicInfoScreen extends StatelessWidget {
  const AcademicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin học tập')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAcademicCard('Thông tin khóa học', [
              _infoRow('Khóa học', '2021 - 2025'),
              _infoRow('Bậc đào tạo', 'Đại học'),
              _infoRow('Loại hình đào tạo', 'Chính quy'),
              _infoRow('Ngành', 'Công nghệ thông tin'),
            ]),
            const SizedBox(height: 16),
            _buildAcademicCard('Trạng thái học tập', [
              _infoRow('Trạng thái', 'Đang học'),
              _infoRow('Học kỳ hiện tại', 'Học kỳ 1 - 2023-2024'),
              _infoRow('Số tín chỉ tích lũy', '85'),
              _infoRow('Điểm trung bình tích lũy', '3.65 (Hệ 4)'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildAcademicCard(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
