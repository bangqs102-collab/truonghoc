import 'package:flutter/material.dart';

class RegistrationResultsScreen extends StatelessWidget {
  const RegistrationResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả đăng ký')),
      body: const Center(child: Text('Kết quả đăng ký học phần')),
    );
  }
}
