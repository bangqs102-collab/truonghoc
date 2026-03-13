import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../providers/auth_provider.dart';
import '../login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin cá nhân')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'Người dùng',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('ID: ${user?.id ?? "N/A"}'),
            const SizedBox(height: 32),
            _buildInfoTile(Icons.email_outlined, 'Email', user?.email ?? 'Chưa cập nhật'),
            _buildInfoTile(Icons.phone_outlined, 'Số điện thoại', '0987 654 321'),
            _buildInfoTile(Icons.school_outlined, 'Vai trò', user?.role.name.toUpperCase() ?? ''),
            const SizedBox(height: 32),
            CustomButton(
              text: 'ĐĂNG XUẤT',
              onPressed: () {
                // 1. Gọi hàm logout trong AuthProvider để xóa dữ liệu user
                context.read<AuthProvider>().logout();
                
                // 2. Điều hướng quay lại màn hình Đăng nhập và xóa sạch các màn hình trước đó
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
