import 'package:flutter/material.dart';

class ThemeCustom {
  ThemeCustom._();
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey.shade900,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade700,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
      ),
      labelMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 24.0,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedBackgroundColor: Colors.grey.shade800,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      collapsedTextColor: Colors.white,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white,
    ),
  );
}
