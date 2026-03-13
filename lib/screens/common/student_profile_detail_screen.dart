import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentProfileDetailScreen extends StatelessWidget {
  const StudentProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ sinh viên')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Nguyễn Văn A', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('MSSV: 20210001', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            _buildInfoCard([
              _infoRow('Ngày sinh', '01/01/2003'),
              _infoRow('Giới tính', 'Nam'),
              _infoRow('Nơi sinh', 'Hà Nội'),
              _infoRow('Dân tộc', 'Kinh'),
            ]),
            const SizedBox(height: 16),
            _buildInfoCard([
              _infoRow('Lớp sinh hoạt', 'CNTT-K21A'),
              _infoRow('Khoa', 'Công nghệ thông tin'),
              _infoRow('Ngành', 'Kỹ thuật phần mềm'),
              _infoRow('Hệ đào tạo', 'Chính quy'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
