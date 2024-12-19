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
      color: Colors.grey.shade800,
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
        color: Colors.white70,
      ),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade800,
        textStyle: const TextStyle(fontSize: 16.0),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white70,
      size: 24.0,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      collapsedBackgroundColor: Colors.grey.shade800,
      backgroundColor: Colors.grey.shade800,
      textColor: Colors.white,
      collapsedTextColor: Colors.white70,
      iconColor: Colors.white70,
      collapsedIconColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    shadowColor: Colors.black12,
  );
}
