import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ScheduleManagementScreen extends StatefulWidget {
  const ScheduleManagementScreen({super.key});

  @override
  State<ScheduleManagementScreen> createState() => _ScheduleManagementScreenState();
}

class _ScheduleManagementScreenState extends State<ScheduleManagementScreen> {
  final List<Map<String, String>> _schedules = [
    {
      'id': '1',
      'subject': 'Phát triển ứng dụng di động',
      'class': 'CNTT-K21A',
      'instructor': 'TS. Lê Văn B',
      'day': 'Thứ 2',
      'time': '07:30 - 09:10',
      'room': 'A1.202',
    },
    {
      'id': '2',
      'subject': 'An toàn thông tin',
      'class': 'CNTT-K21B',
      'instructor': 'ThS. Nguyễn Thị C',
      'day': 'Thứ 4',
      'time': '09:20 - 11:00',
      'room': 'B2.105',
    },
  ];

  void _deleteSchedule(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa lịch học này?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          TextButton(
            onPressed: () {
              setState(() => _schedules.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('XÓA', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Lịch học & Dạy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEditDialog(),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _schedules.length,
        itemBuilder: (context, index) {
          final item = _schedules[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(item['subject']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () => _showAddEditDialog(schedule: item, index: index)),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => _deleteSchedule(index)),
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  _infoRow(Icons.groups, 'Lớp: ', item['class']!),
                  _infoRow(Icons.person, 'GV: ', item['instructor']!),
                  _infoRow(Icons.calendar_today, 'Thứ: ', item['day']!),
                  _infoRow(Icons.access_time, 'Giờ: ', item['time']!),
                  _infoRow(Icons.meeting_room, 'Phòng: ', item['room']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  void _showAddEditDialog({Map<String, String>? schedule, int? index}) {
    final subjectController = TextEditingController(text: schedule?['subject'] ?? '');
    final classController = TextEditingController(text: schedule?['class'] ?? '');
    final instructorController = TextEditingController(text: schedule?['instructor'] ?? '');
    final dayController = TextEditingController(text: schedule?['day'] ?? '');
    final timeController = TextEditingController(text: schedule?['time'] ?? '');
    final roomController = TextEditingController(text: schedule?['room'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(schedule == null ? 'Sắp xếp lịch mới' : 'Điều chỉnh lịch học'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: subjectController, decoration: const InputDecoration(labelText: 'Tên môn học')),
              TextField(controller: classController, decoration: const InputDecoration(labelText: 'Lớp học')),
              TextField(controller: instructorController, decoration: const InputDecoration(labelText: 'Giảng viên')),
              TextField(controller: dayController, decoration: const InputDecoration(labelText: 'Thứ (Ví dụ: Thứ 2)')),
              TextField(controller: timeController, decoration: const InputDecoration(labelText: 'Khung giờ')),
              TextField(controller: roomController, decoration: const InputDecoration(labelText: 'Phòng học')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final data = {
                  'subject': subjectController.text,
                  'class': classController.text,
                  'instructor': instructorController.text,
                  'day': dayController.text,
                  'time': timeController.text,
                  'room': roomController.text,
                };
                if (index == null) {
                  _schedules.add(data);
                } else {
                  _schedules[index] = data;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('LƯU LỊCH'),
          ),
        ],
      ),
    );
  }
}
