import 'package:flutter/material.dart';


class AppConstants {
  AppConstants._();
//hiveboxnme
  static const String journalBox = 'journal_entries';
  static const String moodBox = 'mood_entries';
  static const String settingsBox = 'settings';

//settings
  static const String themeKey = 'selected_theme';
  static const String notificationsKey =
      'notifications_enabled';

  // animations
  static const Duration shortAnim =
      Duration(milliseconds: 200);

  static const Duration mediumAnim =
      Duration(milliseconds: 400);

  static const Duration longAnim =
      Duration(milliseconds:200);
  // Guided Breathing Pattern
  
  static const int breatheInSec = 4;
  static const int holdSec = 4;
  static const int breatheOutSec = 4;

  // Counter
  static const int malaTarget = 108;

  // Completion feedback
  static const String malaCompleteMessage =
      'Successfully completed one mala';
}