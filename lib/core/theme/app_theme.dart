import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color backgroundWarm = Color(0xFFFDFBF7);
  static const Color primaryText = Color(0xFF2D2A26);
  static const Color accentTerra = Color(0xFFE6B89C);
  static const Color accentSage = Color(0xFF9FB8AD);
  static const Color accentBlue = Color(0xFFA0C1D1);
  static const Color errorAnxiety = Color(0xFFEF4444);

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));

  static ThemeData get light {
    final baseTextTheme = GoogleFonts.outfitTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundWarm,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentTerra,
        brightness: Brightness.light,
        surface: backgroundWarm,
        onSurface: primaryText,
        primary: accentTerra,
        secondary: accentSage,
        tertiary: accentBlue,
        error: errorAnxiety,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: primaryText),
        displayMedium: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: primaryText),
        displaySmall: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: primaryText),
        headlineLarge: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: primaryText),
        headlineMedium: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: primaryText),
        headlineSmall: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: primaryText),
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundWarm,
        foregroundColor: primaryText,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: primaryText,
        ),
      ),
    );
  }
}
