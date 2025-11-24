import 'package:ethircle_blk_app/screens/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BLKApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(60, 73, 63, 1),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(60, 73, 63, 1),
  brightness: Brightness.dark,
);

class BLKApp extends StatelessWidget {
  const BLKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ethircle BLK App",
      themeMode: ThemeMode.light,
      theme: getThemeData(kColorScheme),
      darkTheme: getThemeData(kDarkColorScheme),
      home: AppLayout(),
    );
  }

  // This function uses the provided color scheme to return the theme configuration of the application
  ThemeData getThemeData(ColorScheme colorScheme) {
    // Body text default style
    final bodyDefaultStyle = GoogleFonts.openSans(color: colorScheme.onSurface);

    return ThemeData().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: TextTheme().copyWith(
        bodyLarge: bodyDefaultStyle.copyWith(fontSize: 18),
        bodyMedium: bodyDefaultStyle.copyWith(fontSize: 16),
        bodySmall: bodyDefaultStyle.copyWith(fontSize: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
      ),
    );
  }
}
