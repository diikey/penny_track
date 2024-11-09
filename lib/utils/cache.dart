import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  final SharedPreferences _sharedPreferences;

  Cache(this._sharedPreferences);

  //add static strings below for keys
  static const String cacheToken = "cacheToken";

  String getString({required String key}) {
    return _sharedPreferences.getString(key) ?? "";
  }

  Future<void> setString({required String key, required String value}) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<void> removeString({required String key}) async {
    await _sharedPreferences.remove(key);
  }
}
