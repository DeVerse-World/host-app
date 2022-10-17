import 'package:flutter/material.dart';

import '../../data/db/app_storage.dart';
import '../../utils/injection_container.dart';

class SettingsModel extends ChangeNotifier {
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
}
