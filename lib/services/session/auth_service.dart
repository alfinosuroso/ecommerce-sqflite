import 'dart:convert';

import 'package:ecommerce_sqflite/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> storeUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toMap());

    await prefs.setString('user_data', userJson);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_data');

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromMap(userMap);
    }
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }
}
