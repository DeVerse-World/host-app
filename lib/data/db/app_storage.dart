import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  final SharedPreferences _sp;

  AppCache(this._sp);

  void save(String key, dynamic value) async {
    if (value is int) {
      _sp.setInt(key, value);
    } else if (value is bool) {
      _sp.setBool(key, value);
    } else if (value is double) {
      _sp.setDouble(key, value);
    } else if (value is String) {
      _sp.setString(key, value);
    } else if (value is Object) {}
  }

  void saveItemList(String key, List<dynamic> data) {}

  Future<T?> get<T>(String key) async {
    if (T == int) {
      return _sp.getInt(key) as T?;
    } else if (T == bool) {
      return _sp.getBool(key) as T?;
    } else if (T == double) {
      return _sp.getDouble(key) as T?;
    } else if (T == String) {
      return _sp.getString(key) as T?;
    } else if (T == Object) {
      var value = _sp.getString(key);
      return null;
    }
    return null;
  }
}
