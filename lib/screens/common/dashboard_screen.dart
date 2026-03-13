import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_role.dart';

// Student Screens
import '../student/course_registration_screen.dart';
import '../student/academic_info_screen.dart';
import '../student/student_profile_detail_screen.dart';

// Admin Screens
import '../admin/student_management_screen.dart';
import '../admin/schedule_management_screen.dart';

// Lecturer Screens
import '../lecturer/grade_management_screen.dart';

// Common Screens
import 'change_password_screen.dart';
import 'contact_info_screen.dart';
import 'schedule_screen.dart'; 

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _navigateToFeature(BuildContext context, String featureName) {
    if (featureName == 'Profile') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfileDetailScreen()));
      return;
    }
    if (featureName == 'Học tập') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AcademicInfoScreen()));
      return;
    }
    if (featureName == 'Mật khẩu' || featureName == 'Đổi MK') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
      return;
    }
    if (featureName == 'Liên hệ' || featureName == 'Cập nhật') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactInfoScreen()));
      return;
    }
    if (featureName == 'Lịch Học' || featureName == 'Lịch dạy') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleScreen()));
      return;
    }
    if (featureName == 'Đăng ký HP') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseRegistrationScreen()));
      return;
    }
    if (featureName == 'Nhập điểm') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const GradeManagementScreen()));
      return;
    }
    if (featureName == 'QL Sinh viên') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentManagementScreen()));
      return;
    }
    if (featureName == 'QL Lịch học') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleManagementScreen()));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tính năng "$featureName" đang mở...'), backgroundColor: AppColors.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(context, user?.name ?? 'Người dùng', user?.role),
            const SizedBox(height: 24),
            if (user?.role == UserRole.admin) ...[
              _buildSectionTitle(context, 'Quản trị hệ thống'),
              _buildAdminActions(context),
            ] else if (user?.role == UserRole.lecturer) ...[
              _buildSectionTitle(context, 'Quản lý giảng dạy'),
              _buildLecturerActions(context),
            ] else ...[
              _buildSectionTitle(context, 'Tiện ích sinh viên'),
              _buildStudentActions(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, String name, UserRole? role) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 40, color: AppColors.primary)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chào $name!', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Vai trò: ${role?.name?.toUpperCase() ?? "CHƯA RÕ"}', style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        _quickActionItem(context, Icons.event_note, 'Đăng ký HP'),
        _quickActionItem(context, Icons.bar_chart, 'Học tập'),
        _quickActionItem(context, Icons.person, 'Profile'),
        _quickActionItem(context, Icons.lock, 'Mật khẩu'),
      ],
    );
  }

  Widget _buildLecturerActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        _quickActionItem(context, Icons.grading, 'Nhập điểm'),
        _quickActionItem(context, Icons.calendar_month, 'Lịch dạy'),
      ],
    );
  }

  Widget _buildAdminActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        _quickActionItem(context, Icons.people, 'QL Sinh viên'),
        _quickActionItem(context, Icons.calendar_today, 'QL Lịch học'),
      ],
    );
  }

  Widget _quickActionItem(BuildContext context, IconData icon, String label) {
    return InkWell(
      onTap: () => _navigateToFeature(context, label),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(12), 
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            label, 
            style: const TextStyle(fontSize: 10), 
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}