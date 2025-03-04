import 'package:flutter/material.dart';


final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF151B22),
  primaryColor: const Color(0xFF36B37E),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF36B37E),
    secondary: Color(0xFFF86B6B),
    surface: Color(0xFF1C232D),
    background: Color(0xFF151B22),
    error: Color(0xFFF86B6B),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF8F9BB3),
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
  ),
  dividerColor: Colors.grey.shade800,
);

// Light theme
final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFF36B37E),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF36B37E),
    secondary: Color(0xFFF86B6B),
    surface: Color(0xFFF5F7FA),
    background: Colors.white,
    error: Color(0xFFF86B6B),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF2E3A59),
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: Color(0xFF2E3A59),
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF2E3A59),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF8F9BB3),
      fontWeight: FontWeight.normal,
      fontSize: 12,
    ),
  ),
  dividerColor: Colors.grey.shade300,
);