import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ClassScheduleScreen extends StatelessWidget {
  const ClassScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch lớp Sinh hoạt')),
      body: const Center(child: Text('Lịch lớp sinh hoạt')),
    );
  }
}
