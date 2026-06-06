import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
enum AppThemePreset { calmBlue, warmSunset, forestGreen, sleepLavender }

class ThemeProvider extends ChangeNotifier {
  
  ThemeProvider() {
    _loadTheme();
  }

  AppThemePreset _currentPreset = AppThemePreset.calmBlue;

  AppThemePreset get currentPreset => _currentPreset;

  /// Maps enum → actual ThemeData
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
      case AppThemePreset.calmBlue:      return 'Calm Blue';
      case AppThemePreset.warmSunset:    return 'Warm Sunset';
      case AppThemePreset.forestGreen:   return 'Forest Green';
      case AppThemePreset.sleepLavender: return 'Sleep Lavender';
    }
  }

  void setTheme(AppThemePreset preset)async {
    if (_currentPreset == preset) return; // No pointless rebuilds
    _currentPreset = preset;
      _currentPreset = preset;

  final box = Hive.box('settings');

  await box.put('theme', preset.name);

    notifyListeners(); // Tells every widget watching ThemeProvider to rebuild
  }  Future<void> _loadTheme() async {
    final box = Hive.box('settings');

    final savedTheme = box.get('theme');

    if (savedTheme != null) {
      _currentPreset = AppThemePreset.values.firstWhere(
        (preset) => preset.name == savedTheme,
        orElse: () => AppThemePreset.calmBlue,
      );

      notifyListeners();
    }
  }
}