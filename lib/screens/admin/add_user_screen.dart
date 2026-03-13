import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../models/user_role.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  UserRole _selectedRole = UserRole.student;
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm Người dùng mới')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person_add_alt_1, size: 80, color: AppColors.primary),
            const SizedBox(height: 32),
            CustomTextField(
              label: 'Họ và tên',
              hint: 'Nhập họ tên đầy đủ',
              controller: _nameController,
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Mã số (MSSV/MSGV)',
              hint: 'Nhập mã số định danh',
              controller: _idController,
              prefixIcon: Icons.badge_outlined,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Email',
              hint: 'Nhập địa chỉ email',
              controller: _emailController,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 24),
            const Text('Vai trò hệ thống', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<UserRole>(
                  value: _selectedRole,
                  isExpanded: true,
                  items: UserRole.values.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _selectedRole = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'TẠO TÀI KHOẢN',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã tạo người dùng thành công!'), backgroundColor: AppColors.success),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
