import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentProfileDetailScreen extends StatelessWidget {
  const StudentProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ sinh viên')),
      body: const Center(child: Text('Chi tiết hồ sơ sinh viên')),
    );
  }
}
