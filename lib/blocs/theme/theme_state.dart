import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeModes { light, dark }

class ThemeState extends Equatable {
  final ThemeModes themeMode;
  final ThemeData themeData;

  const ThemeState({
    required this.themeMode,
    required this.themeData,
  });

  @override
  List<Object> get props => [themeMode];

  ThemeState copyWith({
    ThemeModes? themeMode,
    ThemeData? themeData,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      themeData: themeData ?? this.themeData,
    );
  }
}
