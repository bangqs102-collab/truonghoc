import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class GradeManagementScreen extends StatefulWidget {
  const GradeManagementScreen({super.key});

  @override
  State<GradeManagementScreen> createState() => _GradeManagementScreenState();
}

class _GradeManagementScreenState extends State<GradeManagementScreen> {
  final List<Map<String, dynamic>> _students = [
    {'id': 'SV001', 'name': 'Nguyễn Văn A', 'midterm': 8.5, 'final': 7.0},
    {'id': 'SV002', 'name': 'Trần Thị B', 'midterm': 7.0, 'final': 9.0},
    {'id': 'SV003', 'name': 'Lê Văn C', 'midterm': 6.5, 'final': 8.0},
  ];

  void _saveGrades() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã lưu bảng điểm thành công!'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhập điểm lớp IT001.L01'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveGrades),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withOpacity(0.05),
            child: const Row(
              children: [
                Expanded(flex: 3, child: Text('Sinh viên', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Giữa kỳ', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('Cuối kỳ', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final sv = _students[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sv['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                            Text(sv['id'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(contentPadding: EdgeInsets.zero),
                          controller: TextEditingController(text: sv['midterm'].toString()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(contentPadding: EdgeInsets.zero),
                          controller: TextEditingController(text: sv['final'].toString()),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _saveGrades,
          child: const Text('LƯU VÀ CÔNG BỐ ĐIỂM'),
        ),
      ),
    );
  }
}
