import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Thông báo đăng ký học phần Học kỳ 2',
        'content': 'Sinh viên lưu ý thời gian đăng ký bắt đầu từ ngày 01/01/2024.',
        'time': '10 phút trước',
        'type': 'daotao'
      },
      {
        'title': 'Nhắc nhở đóng học phí',
        'content': 'Hạn chót đóng học phí học kỳ 1 là ngày 30/11/2023.',
        'time': '2 giờ trước',
        'type': 'taichinh'
      },
      {
        'title': 'Lịch nghỉ lễ Quốc khánh 2/9',
        'content': 'Toàn trường nghỉ từ ngày 01/09 đến hết ngày 03/09/2023.',
        'time': '1 ngày trước',
        'type': 'chung'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: ListTile(
              leading: _buildLeadingIcon(item['type']!),
              title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(item['content']!, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 8),
                  Text(item['time']!, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeadingIcon(String type) {
    IconData icon = Icons.notifications;
    Color color = AppColors.primary;
    if (type == 'daotao') { icon = Icons.school; color = Colors.blue; }
    if (type == 'taichinh') { icon = Icons.account_balance_wallet; color = Colors.orange; }
    
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
