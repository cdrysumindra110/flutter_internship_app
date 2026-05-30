import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'app_theme_mode';
  final SharedPreferences prefs;

  ThemeCubit({required this.prefs}) : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      final themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
      emit(state.copyWith(themeMode: themeMode));
    }
  }

  Future<void> toggleTheme() async {
    final newTheme = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await setTheme(newTheme);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await prefs.setString(_themeKey, themeMode.toString());
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> setSystemTheme() async {
    await prefs.setString(_themeKey, ThemeMode.system.toString());
    emit(state.copyWith(themeMode: ThemeMode.system));
  }
}
