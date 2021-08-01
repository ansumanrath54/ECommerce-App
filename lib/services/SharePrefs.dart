import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPreference {
  static Future<String> getToken() async {
    String token = await SharedPreferences.getInstance()
        .then((sharedPref) => sharedPref.getString('token') ?? '');
    return token;
  }

  static Future<void> setToken(String token) async {
    await SharedPreferences.getInstance()
        .then((sharedPref) => sharedPref.setString('token', token));
  }

  static Future<void> clearToken() async {
    await SharedPreferences.getInstance()
        .then((sharedPref) => sharedPref.setString('token', ''));
  }
}