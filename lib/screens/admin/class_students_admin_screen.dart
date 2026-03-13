import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ClassStudentsAdminScreen extends StatelessWidget {
  final String className;
  const ClassStudentsAdminScreen({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu giả lập danh sách SV trong lớp
    final List<Map<String, String>> students = [
      {'id': 'SV001', 'name': 'Nguyễn Văn A', 'status': 'Đã đăng ký', 'payment': 'Đã đóng'},
      {'id': 'SV002', 'name': 'Trần Thị B', 'status': 'Đã đăng ký', 'payment': 'Chưa đóng'},
      {'id': 'SV005', 'name': 'Lê Hoàng D', 'status': 'Chờ duyệt', 'payment': 'Chưa đóng'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('SV Lớp: $className')),
      body: Column(
        children: [
          _buildSummaryHeader(students.length),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final sv = students[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(child: Text((index + 1).toString())),
                    title: Text(sv['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('MSSV: ${sv['id']} | HP: ${sv['payment']}'),
                    trailing: _buildStatusBadge(sv['status']!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download),
          label: const Text('XUẤT DANH SÁCH (EXCEL)'),
        ),
      ),
    );
  }

  Widget _buildSummaryHeader(int count) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.primary.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _headerItem('Sĩ số', '$count/50', Colors.blue),
          _headerItem('Đã đóng HP', '1', Colors.green),
          _headerItem('Chưa đóng HP', '2', Colors.red),
        ],
      ),
    );
  }

  Widget _headerItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'Đã đăng ký' ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(fontSize: 10, color: status == 'Đã đăng ký' ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
    );
  }
}
