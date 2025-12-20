import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(6, 55, 145, 1),
  brightness: Brightness.light,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(6, 55, 145, 1),
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cs.primary,
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

final title1Style = GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold);

final title2Style = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

final title3Style = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

final title4Style = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
