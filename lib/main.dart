import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ethircle_blk_app/providers/app_mode_provider.dart';
import 'package:ethircle_blk_app/screens/app_layout.dart';
import 'package:ethircle_blk_app/providers/shared_pref_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesWithCache prefsWithCache =
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(),
      );

  runApp(
    ProviderScope(
      overrides: [sharedPrefProvider.overrideWithValue(prefsWithCache)],
      child: BLKApp(),
    ),
  );
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(53, 79, 82, 1),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(53, 79, 82, 1),

  brightness: Brightness.dark,
);

class BLKApp extends ConsumerWidget {
  const BLKApp({super.key});

  ThemeData getAppThemeData(ColorScheme colorScheme) {
    return ThemeData().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: TextStyle(fontWeight: FontWeight.w500),
          padding: EdgeInsets.all(16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontWeight: FontWeight.w500),
          padding: EdgeInsets.all(16),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.primary,
        contentTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);

    return MaterialApp(
      title: 'Ethircle BLK Application',
      themeMode: appMode,
      theme: getAppThemeData(kColorScheme),
      darkTheme: getAppThemeData(kDarkColorScheme),
      home: AppLayout(),
    );
  }
}
