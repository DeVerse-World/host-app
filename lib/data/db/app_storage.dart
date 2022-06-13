import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  Future<SharedPreferences> get _pref {
    return SharedPreferences.getInstance();
  }

  void save(String key, dynamic data) async {

  }

  void saveItemList(String key, List<dynamic> data) {

  }

  Future<T> get<T>(String key) async {
    return (await _pref).get(key) as T;
  }
}