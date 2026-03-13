import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ExamScheduleScreen extends StatelessWidget {
  const ExamScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch Thi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExamCard(
            subject: 'Phát triển ứng dụng di động',
            date: '25/12/2023',
            time: '07:30',
            room: 'Phòng A1.202',
            seat: '25',
            type: 'Cuối kỳ',
          ),
          _buildExamCard(
            subject: 'An toàn thông tin',
            date: '28/12/2023',
            time: '13:30',
            room: 'Phòng B2.105',
            seat: '12',
            type: 'Cuối kỳ',
          ),
          _buildExamCard(
            subject: 'Cấu trúc dữ liệu',
            date: '30/12/2023',
            time: '09:30',
            room: 'Phòng C1.301',
            seat: '05',
            type: 'Giữa kỳ',
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard({
    required String subject,
    required String date,
    required String time,
    required String room,
    required String seat,
    required String type,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: type == 'Cuối kỳ' ? AppColors.primary : AppColors.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(type, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const Icon(Icons.event_note, color: Colors.white, size: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(height: 24),
                Row(
                  children: [
                    _examInfoItem(Icons.calendar_today, 'Ngày', date),
                    const Spacer(),
                    _examInfoItem(Icons.access_time, 'Giờ', time),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _examInfoItem(Icons.meeting_room, 'Phòng', room),
                    const Spacer(),
                    _examInfoItem(Icons.chair, 'Số ghế', seat),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _examInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
