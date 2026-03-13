import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import 'class_detail_screen.dart';
import '../../providers/course_provider.dart';

class AvailableClassesScreen extends StatelessWidget {
  const AvailableClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Lấy dữ liệu Provider tại đây một lần duy nhất để tối ưu hiệu năng
    final courseProvider = context.watch<CourseProvider>();
    final favIds = courseProvider.favoriteSubjectIds;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lớp học phần đang mở'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm chuyên nghiệp
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              hintText: 'Tìm kiếm môn học, mã môn...',
              leading: const Icon(Icons.search, color: Colors.grey),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                final String subjectId = 'IT00${index + 1}';
                final className = 'Kỹ thuật lập trình - Nhóm ${index + 1}';
                final bool isFav = favIds.contains(subjectId);

                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => courseProvider.toggleFavorite(subjectId),
                      ),
                      title: Text(
                        className,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      subtitle: Text(
                        'Mã HP: $subjectId | 3 Tín chỉ',
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(height: 1),
                              const SizedBox(height: 12),
                              _detailRow(Icons.person_outline, 'Giảng viên:', 'TS. Nguyễn Văn A'),
                              _detailRow(Icons.calendar_month_outlined, 'Lịch học:', 'Thứ 2 (1-3), Thứ 4 (4-6)'),
                              _detailRow(Icons.location_on_outlined, 'Phòng học:', 'A1.202'),
                              _detailRow(Icons.people_outline, 'Sĩ số:', '45/50'),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ClassDetailScreen(className: className),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text('XEM CHI TIẾT LỚP', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        )
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

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
