import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CurriculumScreen extends StatelessWidget {
  const CurriculumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chương trình đào tạo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSemesterHeader('Học kỳ 1'),
          _buildSubjectTile('Nhập môn CNTT', '3 tín chỉ', true),
          _buildSubjectTile('Giải tích 1', '4 tín chỉ', true),
          _buildSemesterHeader('Học kỳ 2'),
          _buildSubjectTile('Cấu trúc dữ liệu', '3 tín chỉ', true),
          _buildSubjectTile('Giải tích 2', '4 tín chỉ', false),
          _buildSemesterHeader('Học kỳ 3'),
          _buildSubjectTile('Lập trình hướng đối tượng', '3 tín chỉ', false),
          _buildSubjectTile('Hệ điều hành', '3 tín chỉ', false),
        ],
      ),
    );
  }

  Widget _buildSemesterHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
    );
  }

  Widget _buildSubjectTile(String name, String credits, bool isDone) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(credits),
        trailing: Icon(
          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isDone ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}
