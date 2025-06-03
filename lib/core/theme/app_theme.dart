import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color primary = Color(0xFF1F1F1F);
  static const Color primaryVariant = Color(0xFF2F2F2F);
  static const Color accent = Color(0xFFFFD700);
  static const Color accentVariant = Color(0xFFFFC107);

  static const Color surface = Color(0xFF121212);
  static const Color surfaceVariant = Color(0xFF1E1E1E);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textDisabled = Color(0xFF666666);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Gradients
  static const LinearGradient movieCardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xCC000000), // 80% opacity black
    ],
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE50914), // Vibrant Red (from logo)
      onPrimary: Color(0xFFFFFFFF), // White
      secondary: Color(0xFFFFD700), // Gold (accent)
      onSecondary: Color(0xFF000000), // Black
      background: Color(0xFFE50914), // Vibrant Red (from logo)
      onBackground: Color(0xFFFFFFFF), // White
      surface: Color(0xFFF5F5F5), // Light Gray for light theme surfaces
      onSurface: Color(0xFF212121), // Dark Gray for text on light surfaces
      error: Color(0xFFB00020), // Standard Error Red
      onError: Color(0xFFFFFFFF), // White
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFE50914), // Vibrant Red
      foregroundColor: Color(0xFFFFFFFF), // White
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF5F5F5), // Light Gray
      selectedItemColor: Color(0xFFE50914), // Vibrant Red
      unselectedItemColor: Color(0xFF757575), // Medium Gray
    ),
    cardTheme: CardTheme(
      color: const Color(0xFFFFFFFF), // White
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE50914), // Vibrant Red
        foregroundColor: const Color(0xFFFFFFFF), // White
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFEEEEEE), // Lighter Gray
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    extensions: <ThemeExtension<dynamic>>[AppColors.light],
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFE50914), // Vibrant Red (from logo)
      onPrimary: Color(0xFFFFFFFF), // White
      secondary: Color(0xFFFFD700), // Gold (accent)
      onSecondary: Color(0xFF000000), // Black
      background: Color(0xFFE50914), // Vibrant Red (from logo)
      onBackground: Color(0xFFFFFFFF), // White
      surface: Color(0xFF121212), // Dark Gray for dark theme surfaces
      onSurface: Color(0xFFE0E0E0), // Light Gray for text on dark surfaces
      error: Color(0xFFCF6679), // Standard Error Red for dark theme
      onError: Color(0xFF000000), // Black
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212), // Dark Gray
      foregroundColor: Color(0xFFFFFFFF), // White
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E), // Slightly lighter Dark Gray
      selectedItemColor: Color(0xFFE50914), // Vibrant Red
      unselectedItemColor: Color(0xFFB0B0B0), // Lighter Gray
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E), // Slightly lighter Dark Gray
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE50914), // Vibrant Red
        foregroundColor: const Color(0xFFFFFFFF), // White
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF212121), // Darker Gray
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    extensions: <ThemeExtension<dynamic>>[AppColors.dark],
  );
}
