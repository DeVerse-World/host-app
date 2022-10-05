import 'package:flutter/material.dart';

import '../../data/db/app_storage.dart';
import '../../utils/injection_container.dart';

class SettingsModel extends ChangeNotifier {
  static const _darkThemeKey = "isDarkTheme";
  final AppCache _appStorage = container<AppCache>();

  ThemeMode? _themeMode;

  ThemeMode getThemeMode() {
    if (_themeMode == null) {
      _appStorage.get<bool>(_darkThemeKey).then((value) {
        setDarkTheme(value);
      });
    }
    return _themeMode ?? ThemeMode.system;
  }

  void setDarkTheme(bool? isDark) {
    _themeMode = (isDark ?? false) ? ThemeMode.dark : ThemeMode.light;
    _appStorage.save(_darkThemeKey, isDark);
    notifyListeners();
  }
}
