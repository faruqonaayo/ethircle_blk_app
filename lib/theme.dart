import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(6, 136, 145, 1),
  brightness: Brightness.light,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(6, 136, 145, 1),
  brightness: Brightness.dark,
);

ThemeData getThemeData(ColorScheme cs) {
  return ThemeData().copyWith(
    colorScheme: cs,
    scaffoldBackgroundColor: cs.surface,
    textTheme: GoogleFonts.openSansTextTheme().apply(
      bodyColor: cs.onSurface,
      displayColor: cs.onSurface,
    ),
  );
}
