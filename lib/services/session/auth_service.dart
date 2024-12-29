import 'dart:convert';

import 'package:ecommerce_sqflite/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static Future<void> storeUser(User user) async {
    String userJson = jsonEncode(user.toMap());

    await prefs?.setString('user_data', userJson);
  }

  static User? getUser() {
    String? userJson = prefs?.getString('user_data');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromMap(userMap);
    }
    return null;
  }

  static Future<void> clearUser() async {
    await prefs?.clear();
  }
}
