import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  static Future<String> getStringToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return '$token';
  }

  static Future<bool> removeStringToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }

  static Future<bool> saveUserId(int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('user_id', value);
  }

  static Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt('user_id');
    return userid ?? 0;
  }

  static Future<bool> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('user_id');
  }
}
