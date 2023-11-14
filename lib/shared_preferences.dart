import 'package:shared_preferences/shared_preferences.dart';

enum AppStorageKey { id, role }

class AppLocalStorage {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<void> setString(AppStorageKey key, String value) async {
    (await prefs).setString(key.toString(), value);
  }

  static Future<String?> getString(AppStorageKey key) async {
    return (await prefs).getString(key.toString());
  }

  static Future<bool> isExist(AppStorageKey key) async {
    return (await prefs).containsKey(key.toString());
  }

  static Future<void> delete(AppStorageKey key) async {
    (await prefs).remove(key.toString());
  }
}
