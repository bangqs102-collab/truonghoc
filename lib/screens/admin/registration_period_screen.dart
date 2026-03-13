import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_colors.dart';

class RegistrationPeriodScreen extends StatefulWidget {
  const RegistrationPeriodScreen({super.key});

  @override
  State<RegistrationPeriodScreen> createState() => _RegistrationPeriodScreenState();
}

class _RegistrationPeriodScreenState extends State<RegistrationPeriodScreen> {
  final List<Map<String, dynamic>> _periods = [
    {
      'semester': 'Học kỳ 1 (2023-2024)',
      'start': DateTime(2023, 8, 1, 8, 0),
      'end': DateTime(2023, 8, 15, 23, 59),
      'subjects': ['Kỹ thuật lập trình', 'Cấu trúc dữ liệu'],
      'isActive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cấu hình Đợt đăng ký')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _periods.length,
        itemBuilder: (context, index) {
          final period = _periods[index];
          final DateFormat formatter = DateFormat('HH:mm - dd/MM/yyyy');
          
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: AppColors.primary, width: 0.5)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(period['semester'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: AppColors.primary)),
                      Switch(
                        value: period['isActive'],
                        onChanged: (val) => setState(() => period['isActive'] = val),
                      ),
                    ],
                  ),
                  const Divider(),
                  _infoRow(Icons.play_circle_outline, 'Bắt đầu:', formatter.format(period['start'])),
                  _infoRow(Icons.stop_circle_outlined, 'Kết thúc:', formatter.format(period['end'])),
                  const SizedBox(height: 8),
                  const Text('Môn học áp dụng:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Wrap(
                    spacing: 8,
                    children: (period['subjects'] as List<String>).map((s) => Chip(
                      label: Text(s, style: const TextStyle(fontSize: 11)),
                      backgroundColor: AppColors.primary.withOpacity(0.05),
                    )).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showConfigDialog(),
        label: const Text('Tạo đợt đăng ký mới'),
        icon: const Icon(Icons.add_alarm),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Hộp thoại cấu hình chi tiết (Ngày & Giờ)
  void _showConfigDialog() async {
    DateTime startDate = DateTime.now();
    TimeOfDay startTime = TimeOfDay.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 7));
    TimeOfDay endTime = const TimeOfDay(hour: 23, minute: 59);
    List<String> selectedSubjects = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Cấu hình thời gian mở'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Thời điểm bắt đầu:', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(context: context, initialDate: startDate, firstDate: DateTime.now(), lastDate: DateTime(2030));
                        if (date != null) setDialogState(() => startDate = date);
                      },
                      child: Text(DateFormat('dd/MM/yyyy').format(startDate)),
                    ),
                    TextButton(
                      onPressed: () async {
                        final time = await showTimePicker(context: context, initialTime: startTime);
                        if (time != null) setDialogState(() => startTime = time);
                      },
                      child: Text(startTime.format(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Thời điểm kết thúc:', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(context: context, initialDate: endDate, firstDate: DateTime.now(), lastDate: DateTime(2030));
                        if (date != null) setDialogState(() => endDate = date);
                      },
                      child: Text(DateFormat('dd/MM/yyyy').format(endDate)),
                    ),
                    TextButton(
                      onPressed: () async {
                        final time = await showTimePicker(context: context, initialTime: endTime);
                        if (time != null) setDialogState(() => endTime = time);
                      },
                      child: Text(endTime.format(context)),
                    ),
                  ],
                ),
                const Divider(height: 32),
                const Text('Chọn môn học mở đăng ký:', style: TextStyle(fontWeight: FontWeight.bold)),
                _subjectCheckbox('Kỹ thuật lập trình', selectedSubjects, setDialogState),
                _subjectCheckbox('Cấu trúc dữ liệu', selectedSubjects, setDialogState),
                _subjectCheckbox('Lập trình di động', selectedSubjects, setDialogState),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _periods.add({
                    'semester': 'Đợt mới cấu hình',
                    'start': DateTime(startDate.year, startDate.month, startDate.day, startTime.hour, startTime.minute),
                    'end': DateTime(endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute),
                    'subjects': selectedSubjects,
                    'isActive': true,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('LƯU CẤU HÌNH'),
            )
          ],
        ),
      ),
    );
  }

  Widget _subjectCheckbox(String name, List<String> selected, StateSetter setDialogState) {
    return CheckboxListTile(
      title: Text(name, style: const TextStyle(fontSize: 14)),
      value: selected.contains(name),
      onChanged: (val) {
        setDialogState(() {
          if (val == true) selected.add(name); else selected.remove(name);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
