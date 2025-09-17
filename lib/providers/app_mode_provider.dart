import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ethircle_blk_app/providers/shared_pref_provider.dart';

class AppModeNotifier extends StateNotifier<ThemeMode> {
  AppModeNotifier(this.sharedPref, this.initialMode) : super(initialMode);

  final SharedPreferencesWithCache sharedPref;
  final ThemeMode initialMode;

  void toggleMode() async {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      await sharedPref.setString("appMode", "dark");
    } else {
      state = ThemeMode.light;
      await sharedPref.setString("appMode", "light");
    }
  }
}

final appModeProvider = StateNotifierProvider<AppModeNotifier, ThemeMode>((
  ref,
) {
  final sharedPreferencesWithCache = ref.read(sharedPrefProvider);

  final appMode = sharedPreferencesWithCache.getString("appMode");

  if (appMode == "dark") {
    return AppModeNotifier(sharedPreferencesWithCache, ThemeMode.dark);
  }

  return AppModeNotifier(sharedPreferencesWithCache, ThemeMode.light);
});
