import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smallbytes/core/models/user_model.dart';
import 'package:smallbytes/features/auth/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  User? _user;
  bool _isLoggedIn=false;
  String userId ="";


  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  AuthViewModel(this._authService) {
    loadUser();
  }

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("uid")  && prefs.getBool("isLoggedIn")==true)
        {

          _isLoggedIn =true;
          notifyListeners();
        }


    try {


      final user = await _authService.getUser();
      if (user != null) {
        _user = user;
        _isLoggedIn =true;
      await  prefs.setBool("isLoggedIn", true);
      await  prefs.setString("isLoggedIn", user.$id);
      notifyListeners();

      } else {
        _user = null;
       await prefs.remove("uid");
       await prefs.setBool("isLoggedIn",false);
       _isLoggedIn =false;
        notifyListeners();
      }

    } catch (e) {
      _user = null;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
    await loadUser();
  }

  Future<User> signUp(String email, String password, String name) async {
    User user = await _authService.signUp(email, password, name);
    await loadUser();
    return user;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _authService.logout();
    _user = null;
    _isLoggedIn =false;
    await prefs.remove("uid");
    await prefs.setBool("isLoggedIn",false);
    notifyListeners();
  }
}
