import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../theme/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _handleChangePassword() async {
    setState(() => _isLoading = true);
    // Giả lập gọi API đổi mật khẩu
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đổi mật khẩu thành công!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đổi mật khẩu')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock_reset, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _oldPasswordController,
              label: 'Mật khẩu hiện tại',
              hint: 'Nhập mật khẩu cũ',
              isPassword: true,
              prefixIcon: Icons.lock_outline,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _newPasswordController,
              label: 'Mật khẩu mới',
              hint: 'Nhập mật khẩu mới',
              isPassword: true,
              prefixIcon: Icons.vpn_key_outlined,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _confirmPasswordController,
              label: 'Xác nhận mật khẩu mới',
              hint: 'Nhập lại mật khẩu mới',
              isPassword: true,
              prefixIcon: Icons.check_circle_outline,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'XÁC NHẬN ĐỔI MẬT KHẨU',
              isLoading: _isLoading,
              onPressed: _handleChangePassword,
            ),
          ],
        ),
      ),
    );
  }
}
