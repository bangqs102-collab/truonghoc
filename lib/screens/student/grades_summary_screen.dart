import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_colors.dart';

class GradesSummaryScreen extends StatelessWidget {
  const GradesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả học tập')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGPAOverview(context),
            const SizedBox(height: 24),
            Text('Biểu đồ tiến độ GPA', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildGradesChart(),
            const SizedBox(height: 24),
            Text('Thống kê tín chỉ', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildCreditStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildGPAOverview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _gpaItem('GPA Hệ 4', '3.65', AppColors.primary),
          _gpaItem('Hệ 10', '8.5', AppColors.secondary),
          _gpaItem('Xếp loại', 'Giỏi', Colors.green),
        ],
      ),
    );
  }

  Widget _gpaItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildGradesChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 20, top: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          titlesData: const FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [const FlSpot(1, 3.2), const FlSpot(2, 3.5), const FlSpot(3, 3.4), const FlSpot(4, 3.65)],
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditStats() {
    return Column(
      children: [
        _creditRow('Tín chỉ tích lũy', '85 / 132', 0.64, Colors.blue),
        const SizedBox(height: 12),
        _creditRow('Tín chỉ GDQP', '8 / 8', 1.0, Colors.green),
        const SizedBox(height: 12),
        _creditRow('Tín chỉ Tiếng Anh', '12 / 20', 0.6, Colors.orange),
      ],
    );
  }

  Widget _creditRow(String label, String value, double percent, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))]),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: percent, backgroundColor: color.withOpacity(0.1), color: color, minHeight: 8),
        ],
      ),
    );
  }
}
