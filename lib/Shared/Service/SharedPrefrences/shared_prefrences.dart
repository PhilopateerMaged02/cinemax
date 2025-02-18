import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesSingleton {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _instance!.setBool(key, value);
  }

  static bool getBool(String key) {
    return _instance!.getBool(key) ?? false;
  }

  static Future<bool> setString(String key, String value) async {
    return await _instance!.setString(key, value);
  }

  static String? getString(String key) {
    return _instance!.getString(key);
  }

  static dynamic getData({required String key}) {
    return _instance!.get(key);
  }
}
