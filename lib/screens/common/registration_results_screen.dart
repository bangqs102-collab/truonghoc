import 'package:flutter/material.dart';

class RegistrationResultsScreen extends StatelessWidget {
  const RegistrationResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả đăng ký')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatusCard(
            subject: 'Phát triển ứng dụng di động',
            status: 'Thành công',
            time: '20/08/2023 14:30',
            color: Colors.green,
          ),
          _buildStatusCard(
            subject: 'An toàn thông tin',
            status: 'Thành công',
            time: '20/08/2023 14:31',
            color: Colors.green,
          ),
          _buildStatusCard(
            subject: 'Cấu trúc dữ liệu',
            status: 'Thất bại (Trùng lịch)',
            time: '20/08/2023 14:35',
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required String subject,
    required String status,
    required String time,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(color == Colors.green ? Icons.check : Icons.close, color: color),
        ),
        title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Thời gian: $time'),
        trailing: Text(
          status,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}
