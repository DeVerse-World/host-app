import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  AppStorage();

  Future<SharedPreferences> get _pref {
    return SharedPreferences.getInstance();
  }

  void save(String key, dynamic value) async {
    _pref.then((sp) {
      if (value is int) {
        sp.setInt(key, value);
      } else if (value is bool) {
        sp.setBool(key, value);
      } else if (value is double) {
        sp.setDouble(key, value);
      } else if (value is String) {
        sp.setString(key, value);
      } else if (value is Object) {}
    });
  }

  void saveItemList(String key, List<dynamic> data) {}

  Future<T?> get<T>(String key) async {
    return _pref.then((sp) {
      if (T == int) {
        return sp.getInt(key) as T?;
      } else if (T == bool) {
        return sp.getBool(key) as T?;
      } else if (T == double) {
        return sp.getDouble(key) as T?;
      } else if (T == String) {
        return sp.getString(key) as T?;
      } else if (T == Object) {
        var value = sp.getString(key);
        return null;
      }
      return null;
    });
  }
}