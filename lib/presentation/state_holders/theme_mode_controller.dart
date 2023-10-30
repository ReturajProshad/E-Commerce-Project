import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController {
  ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  static const themeModeKey = 'theme_mode';

  ThemeModeController() {
    Future.delayed(Duration.zero, () {
      loadSavedThemeMode();
    });
  }

  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    saveCurrentThemeMode(mode);
  }

  void toggleThemeMode() {
    if (themeMode.value == ThemeMode.light) {
      changeThemeMode(ThemeMode.dark);
    } else {
      changeThemeMode(ThemeMode.light);
    }
  }

  void saveCurrentThemeMode(ThemeMode mode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(themeModeKey, mode.index);
  }

  void loadSavedThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final savedModeIndex = preferences.getInt(themeModeKey);
    if (savedModeIndex != null) {
      final savedMode = ThemeMode.values[savedModeIndex];
      themeMode.value = savedMode;
    }
  }
}
