import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeManager {
  // Singleton instance
  static final ThemeManager _instance = ThemeManager._internal();

  // Private constructor
  ThemeManager._internal();

  // Getter for the singleton instance
  static ThemeManager get instance => _instance;

  // Method channel for theme communication
  final platform = const MethodChannel('com.method_channel_example/theme');

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

      log('Tema değiştirildi: $newThemeMode $currentThemeMode');
    } on PlatformException catch (e) {
      PlatformException(code: e.code, details: e.details, message: e.message);
      log('Tema değişikliği hatası: ${e.message}');
    }
  }

  // Get ThemeData based on current theme mode
  ThemeData getThemeData() {
    return _currentThemeMode == ThemeMode.light
        ? ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.blue.shade100,
            appBarTheme: AppBarTheme(
              color: Colors.blue,
            ),
          )
        : ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.grey.shade900,
            appBarTheme: AppBarTheme(
              color: Colors.grey.shade800,
            ),
          );
  }
}
