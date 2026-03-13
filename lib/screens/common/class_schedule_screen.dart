import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ClassScheduleScreen extends StatelessWidget {
  const ClassScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch lớp Sinh hoạt')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildClassMeetingCard(
            title: 'Họp lớp định kỳ tháng 10',
            date: '15/10/2023',
            time: '08:00 - 10:00',
            location: 'Phòng sinh hoạt chung A2',
            note: 'Phổ biến quy chế thi đua và khen thưởng học kỳ mới.',
          ),
          _buildClassMeetingCard(
            title: 'Sinh hoạt chủ nhiệm tuần 8',
            date: '22/10/2023',
            time: '14:00 - 15:30',
            location: 'Trực tuyến (Google Meet)',
            note: 'Thảo luận về kế hoạch tham gia hội trại trường.',
          ),
        ],
      ),
    );
  }

  Widget _buildClassMeetingCard({
    required String title,
    required String date,
    required String time,
    required String location,
    required String note,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.groups, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _infoRow(Icons.calendar_month, 'Ngày:', date),
            const SizedBox(height: 8),
            _infoRow(Icons.access_time, 'Thời gian:', time),
            const SizedBox(height: 8),
            _infoRow(Icons.location_on_outlined, 'Địa điểm:', location),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Lưu ý: $note',
                style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
