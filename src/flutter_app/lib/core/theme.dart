import 'package:flutter/material.dart';

class AppTheme {
  static const _primary = Color(0xFFFA9B9B);
  static const _secondary = Color(0xFFE88087);
  static const _background = Color(0xFFF7F3D5);
  static const _surface = Color(0xFFFFDABF);
  static const _text = Color(0xFF635063);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      primary: _primary,
      secondary: _secondary,
      surface: _surface,
      background: _background,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _text,
      onBackground: _text,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _background,
      textTheme: Typography.blackMountainView.apply(
        bodyColor: _text,
        displayColor: _text,
        fontFamily: 'Roboto',
      ),
      cardTheme: const CardTheme(color: _surface),
    );
  }
}
