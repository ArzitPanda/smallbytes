// src/core/services/auth_service.dart


import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AuthService {
  final Account _account;



  AuthService(this._account);

  Future<User> signUp(String email, String password,String name) async {
  User user= await _account.create( email: email, password: password,userId: ID.unique(),name:name );
  print(user.$id);
  return user;
  }

  Future<Session> login(String email, String password) async {
    return await _account.createEmailPasswordSession(email: email, password: password);
  }



  Future<void> logout() async {
    await _account.deleteSession(sessionId: 'current');
  }

  Future<User?> getUser() async {
    try {
      User a = await _account.get();
      print("${a.name} ${a.$id}");

      return a;
    } catch (e) {
      return null;
    }

  }
}
