import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AppThemePreset {
  calmBlue,
  warmSunset,
  forestGreen,
  sleepLavender,
}

class ThemeProvider extends ChangeNotifier {
  AppThemePreset _currentPreset =
      AppThemePreset.calmBlue;

  AppThemePreset get currentPreset =>
      _currentPreset;

  ThemeData get currentTheme {
    switch (_currentPreset) {
      case AppThemePreset.calmBlue:
        return AppTheme.calmBlue;

      case AppThemePreset.warmSunset:
        return AppTheme.warmSunset;

      case AppThemePreset.forestGreen:
        return AppTheme.forestGreen;

      case AppThemePreset.sleepLavender:
        return AppTheme.sleepLavender;
    }
  }

  String get currentPresetLabel {
    switch (_currentPreset) {
      case AppThemePreset.calmBlue:
        return 'Calm Blue';

      case AppThemePreset.warmSunset:
        return 'Warm Sunset';

      case AppThemePreset.forestGreen:
        return 'Forest Green';

      case AppThemePreset.sleepLavender:
        return 'Sleep Lavender';
    }
  }

  void setTheme(AppThemePreset preset) {
    if (_currentPreset == preset) return;

    _currentPreset = preset;

    notifyListeners();
  }
}