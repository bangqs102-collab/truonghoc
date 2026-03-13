import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScholarshipScreen extends StatelessWidget {
  const ScholarshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Học bổng')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildScholarshipCard(
            title: 'Học bổng Khuyến khích học tập',
            semester: 'Học kỳ 2 (2022-2023)',
            amount: '5,000,000đ',
            status: 'Đã nhận',
            date: '20/06/2023',
            color: Colors.green,
          ),
          _buildScholarshipCard(
            title: 'Học bổng Doanh nghiệp tài trợ',
            semester: 'Học kỳ 1 (2023-2024)',
            amount: '2,000,000đ',
            status: 'Đang xét duyệt',
            date: '01/10/2023',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildScholarshipCard({
    required String title,
    required String semester,
    required String amount,
    required String status,
    required String date,
    required Color color,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const Divider(height: 24),
            _infoRow(Icons.calendar_today, 'Học kỳ:', semester),
            const SizedBox(height: 8),
            _infoRow(Icons.payments_outlined, 'Số tiền:', amount),
            const SizedBox(height: 8),
            _infoRow(Icons.event, 'Ngày nhận/cập nhật:', date),
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
