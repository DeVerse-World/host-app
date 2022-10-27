import 'package:flutter/material.dart';

import '../../data/api/response_body.dart';
import '../../data/api/result.dart';
import '../../data/db/app_storage.dart';
import '../../repositories/user_repository.dart';
import '../../utils/injection_container.dart';

class SettingsModel extends ChangeNotifier {
  final UserRepository _userRepository = container<UserRepository>();
  User? _user;

  User? get user => _user ?? _userRepository.user;

  static const _darkThemeKey = "isDarkTheme";
  final AppCache _appStorage = container<AppCache>();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  String get currentMode {
    if (_themeMode == ThemeMode.dark) return "Dark";
    return "Light";
  }

  SettingsModel() {
    _appStorage.get<bool>(_darkThemeKey).then((value) {
      setTheme(value);
    });
  }

  void setTheme(bool? isDark) {
    if (bool == null) {
      return;
    }
    _themeMode = (isDark ?? false) ? ThemeMode.dark : ThemeMode.light;
    _appStorage.save(_darkThemeKey, isDark);
    notifyListeners();
  }

  Future<Result<UserResponse, Exception>> updateProfile(String name) async {
    final result = await _userRepository.updateProfile(name);
    if (result.isSuccess) {
      _user = result.data?.user;
      notifyListeners();
    }
    return result;
  }
}
