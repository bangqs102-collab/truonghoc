import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../theme/app_colors.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final _emailController = TextEditingController(text: 'a.nguyen@school.edu.vn');
  final _phoneController = TextEditingController(text: '0987 654 321');
  final _addressController = TextEditingController(text: '123 Đường ABC, Quận 1, TP.HCM');
  bool _isEditing = false;

  void _handleUpdate() {
    if (_isEditing) {
      // Giả lập lưu dữ liệu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thông tin thành công!'), backgroundColor: AppColors.success),
      );
    }
    setState(() => _isEditing = !_isEditing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin liên hệ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.contact_mail, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _emailController,
              label: 'Email cá nhân',
              hint: 'Nhập email của bạn',
              prefixIcon: Icons.email_outlined,
              // Giả sử CustomTextField có thuộc tính enabled, nếu không ta dùng ReadOnly
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _phoneController,
              label: 'Số điện thoại',
              hint: 'Nhập số điện thoại',
              prefixIcon: Icons.phone_android_outlined,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _addressController,
              label: 'Địa chỉ thường trú',
              hint: 'Nhập địa chỉ',
              prefixIcon: Icons.home_outlined,
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: _isEditing ? 'LƯU THÔNG TIN' : 'CHỈNH SỬA THÔNG TIN',
              onPressed: _handleUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
