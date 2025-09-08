import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/screens/app_layout.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BLKApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(34, 40, 49, 1),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(34, 40, 49, 1),
  brightness: Brightness.dark,
);

class BLKApp extends StatelessWidget {
  const BLKApp({super.key});

  ThemeData getAppThemeData(ColorScheme colorScheme) {
    return ThemeData().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: GoogleFonts.latoTextTheme().apply(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethircle BLK Application',
      themeMode: ThemeMode.light,
      theme: getAppThemeData(kColorScheme),
      darkTheme: getAppThemeData(kDarkColorScheme),
      home: AppLayout(),
    );
  }
}
