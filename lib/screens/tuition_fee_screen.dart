import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TuitionFeeScreen extends StatelessWidget {
  const TuitionFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Học phí')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          const Text('Danh sách hóa đơn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _buildTuitionItem(
            title: 'Học phí Học kỳ 1 (2023-2024)',
            amount: '12,500,000đ',
            status: 'Đã thanh toán',
            date: '15/08/2023',
            isPaid: true,
          ),
          _buildTuitionItem(
            title: 'Lệ phí thi lại (Tiếng Anh)',
            amount: '250,000đ',
            status: 'Chưa thanh toán',
            date: '10/10/2023',
            isPaid: false,
          ),
          _buildTuitionItem(
            title: 'Bảo hiểm y tế (2024)',
            amount: '680,400đ',
            status: 'Đã thanh toán',
            date: '05/09/2023',
            isPaid: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tổng công nợ hiện tại', style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 8),
          Text('250,000đ', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Divider(color: Colors.white24),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Đã đóng: 13,180,400đ', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('Hạn chót: 30/11/2023', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTuitionItem({
    required String title,
    required String amount,
    required String status,
    required String date,
    required bool isPaid,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Ngày lập: $date', style: const TextStyle(fontSize: 12)),
            Text('Số tiền: $amount', style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isPaid ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: isPaid ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
