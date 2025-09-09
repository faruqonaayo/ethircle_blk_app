import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppModeNotifier extends StateNotifier<ThemeMode> {
  AppModeNotifier() : super(ThemeMode.light);

  void toggleMode() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

final appModeProvider = StateNotifierProvider<AppModeNotifier, ThemeMode>(
  (ref) => AppModeNotifier(),
);
