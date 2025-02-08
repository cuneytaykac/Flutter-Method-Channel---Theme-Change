import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();

  ThemeManager._internal();

  static ThemeManager get instance => _instance;

  // Method channel for theme communication
  static const platform = MethodChannel('com.method_channel_example/theme');

  // Current theme mode
  ThemeMode _currentThemeMode = ThemeMode.light;

  // Getter for current theme mode
  ThemeMode get currentThemeMode => _currentThemeMode;

  // Theme change method
  Future<void> toggleTheme() async {
    try {
      // Determine new theme mode
      final newThemeMode =
          _currentThemeMode == ThemeMode.light ? 'dark' : 'light';

      // Send theme change request via method channel
      final result = await platform.invokeMethod('changeTheme', newThemeMode);

      // Update local theme mode
      _currentThemeMode =
          newThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;

      log('Tema değiştirildi: $newThemeMode');
    } on PlatformException catch (e) {
      log('Tema değişikliği hatası: ${e.message}');
    }
  }

  // Get ThemeData based on current theme mode
  ThemeData getThemeData() {
    return _currentThemeMode == ThemeMode.light
        ? ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.blue,
            appBarTheme: const AppBarTheme(color: Colors.blue),
          )
        : ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.red,
            appBarTheme: const AppBarTheme(color: Colors.red),
          );
  }

  // Check if current theme is dark
  bool get isDarkMode => _currentThemeMode == ThemeMode.dark;
}
