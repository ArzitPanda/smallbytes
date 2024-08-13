import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:smallbytes/core/models/user_model.dart';
import 'package:smallbytes/features/auth/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  UserModel? _user;

  UserModel? get user => _user;

  AuthViewModel(this._authService) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _authService.getUser();
      if (user != null) {
        _user = UserModel.fromJson(user.toMap());
      } else {
        _user = null;
      }
      notifyListeners();
    } catch (e) {
      _user = null;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
    await _loadUser();
  }

  Future<User> signUp(String email, String password, String name) async {
    User user = await _authService.signUp(email, password, name);
    await _loadUser();
    return user;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
