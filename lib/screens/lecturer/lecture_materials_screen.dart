import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LectureMaterialsScreen extends StatelessWidget {
  const LectureMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tài liệu bài giảng')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMaterialCard('Phát triển di động', 'Chương 1: Giới thiệu Flutter', 'PDF', '15/08/2023'),
          _buildMaterialCard('Phát triển di động', 'Bài tập tuần 2', 'DOCX', '22/08/2023'),
          _buildMaterialCard('Cấu trúc dữ liệu', 'Slide bài giảng cây nhị phân', 'PPTX', '10/09/2023'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.upload_file, color: Colors.white),
      ),
    );
  }

  Widget _buildMaterialCard(String course, String title, String type, String date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: _buildFileIcon(type),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$course | Ngày đăng: $date'),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }

  Widget _buildFileIcon(String type) {
    Color color = Colors.blue;
    IconData icon = Icons.insert_drive_file;
    if (type == 'PDF') { color = Colors.red; icon = Icons.picture_as_pdf; }
    if (type == 'PPTX') { color = Colors.orange; icon = Icons.slideshow; }
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, color: color),
    );
  }
}
