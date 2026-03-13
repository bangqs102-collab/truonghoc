import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/user_role.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    // Giả lập gọi API login
    await Future.delayed(const Duration(seconds: 2));

    // Logic giả lập phân quyền dựa trên username
    if (username.toLowerCase() == 'admin') {
      _user = User(
        id: 'AD001',
        name: 'Quản trị viên',
        email: 'admin@school.edu.vn',
        role: UserRole.admin,
      );
    } else if (username.toLowerCase().startsWith('gv')) {
      _user = User(
        id: username,
        name: 'Giảng viên Nguyễn Văn B',
        email: 'gv.vanb@school.edu.vn',
        role: UserRole.lecturer,
      );
    } else {
      _user = User(
        id: username,
        name: 'Sinh viên Nguyễn Văn A',
        email: 'sv.vana@school.edu.vn',
        role: UserRole.student,
      );
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
