import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CourseManagementScreen extends StatefulWidget {
  const CourseManagementScreen({super.key});

  @override
  State<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  final List<Map<String, dynamic>> _courses = [
    {'id': 'IT001', 'name': 'Kỹ thuật lập trình', 'credits': 3, 'type': 'Bắt buộc'},
    {'id': 'IT002', 'name': 'Cấu trúc dữ liệu', 'credits': 4, 'type': 'Bắt buộc'},
    {'id': 'IT003', 'name': 'Lập trình di động', 'credits': 3, 'type': 'Tự chọn'},
  ];

  void _deleteCourse(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa học phần ${_courses[index]['name']}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
          TextButton(
            onPressed: () {
              setState(() {
                _courses.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa học phần thành công'), backgroundColor: AppColors.error),
              );
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
        title: const Text('Quản lý Học phần'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => _showAddEditDialog()),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SearchBar(
              hintText: 'Tìm kiếm học phần...',
              leading: Icon(Icons.search),
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(course['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Mã HP: ${course['id']} | Tín chỉ: ${course['credits']}'),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: course['type'] == 'Bắt buộc' ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            course['type'],
                            style: TextStyle(
                              fontSize: 10,
                              color: course['type'] == 'Bắt buộc' ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                          onPressed: () => _showAddEditDialog(course: course, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _deleteCourse(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog({Map<String, dynamic>? course, int? index}) {
    final nameController = TextEditingController(text: course?['name'] ?? '');
    final idController = TextEditingController(text: course?['id'] ?? '');
    final creditController = TextEditingController(text: course?['credits']?.toString() ?? '');
    String selectedType = course?['type'] ?? 'Bắt buộc';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(course == null ? 'Thêm Học phần' : 'Sửa Học phần'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Tên học phần'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'Mã học phần'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: creditController,
                  decoration: const InputDecoration(labelText: 'Số tín chỉ'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Loại môn học:'),
                    DropdownButton<String>(
                      value: selectedType,
                      items: ['Bắt buộc', 'Tự chọn'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setDialogState(() {
                            selectedType = newValue;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('HỦY')),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || idController.text.isEmpty || creditController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin'), backgroundColor: Colors.orange),
                  );
                  return;
                }

                setState(() {
                  final newCourse = {
                    'id': idController.text,
                    'name': nameController.text,
                    'credits': int.tryParse(creditController.text) ?? 0,
                    'type': selectedType,
                  };

                  if (index == null) {
                    _courses.add(newCourse);
                  } else {
                    _courses[index] = newCourse;
                  }
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(index == null ? 'Đã thêm học phần mới' : 'Đã cập nhật học phần'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: const Text('LƯU'),
            ),
          ],
        ),
      ),
    );
  }
}
