import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TuitionFeeScreen extends StatelessWidget {
  const TuitionFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Học phí')),
      body: const Center(child: Text('Thông tin học phí')),
    );
  }
}
