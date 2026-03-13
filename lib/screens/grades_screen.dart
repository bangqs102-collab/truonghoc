import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_colors.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

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
            Text(
              'Biểu đồ tiến độ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildGradesChart(),
            const SizedBox(height: 24),
            Text(
              'Danh sách môn học',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _buildGradesList(),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _gpaItem('GPA Hệ 4', '3.65', AppColors.primary),
          Container(width: 1, height: 40, color: Colors.grey.shade300),
          _gpaItem('GPA Hệ 10', '8.5', AppColors.secondary),
          Container(width: 1, height: 40, color: Colors.grey.shade300),
          _gpaItem('Tín chỉ', '85/132', Colors.green),
        ],
      ),
    );
  }

  Widget _gpaItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildGradesChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3.2),
                const FlSpot(1, 3.5),
                const FlSpot(2, 3.1),
                const FlSpot(3, 3.8),
                const FlSpot(4, 3.65),
              ],
              isCurved: true,
              color: AppColors.primary,
              barWidth: 4,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradesList() {
    final subjects = [
      {'name': 'Cấu trúc dữ liệu', 'grade': 'A', 'point': 4.0},
      {'name': 'Toán rời rạc', 'grade': 'B+', 'point': 3.5},
      {'name': 'Lập trình Java', 'grade': 'A', 'point': 4.0},
      {'name': 'Mạng máy tính', 'grade': 'B', 'point': 3.0},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final sub = subjects[index];
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            title: Text(sub['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                sub['grade'] as String,
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
