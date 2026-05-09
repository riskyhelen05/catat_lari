import 'package:flutter/material.dart';

class AppTheme {

  // LIGHT THEME
  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    primarySwatch: Colors.green,

    scaffoldBackgroundColor:
        const Color(0xFFF5F7FA),

    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(

      backgroundColor: Colors.white,

      foregroundColor: Colors.black,

      elevation: 0,

      centerTitle: true,
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),

    cardTheme: CardThemeData(

      color: Colors.white,

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),

    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(

      selectedItemColor: Colors.green,

      unselectedItemColor: Colors.grey,

      showUnselectedLabels: false,

      type: BottomNavigationBarType.fixed,
    ),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    primarySwatch: Colors.green,

    scaffoldBackgroundColor:
        const Color(0xFF121212),

    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(

      backgroundColor: Color(0xFF1E1E1E),

      elevation: 0,

      centerTitle: true,
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),

    cardTheme: CardThemeData(

      color: const Color(0xFF1E1E1E),

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
    ),

    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(

      backgroundColor: Color(0xFF1E1E1E),

      selectedItemColor: Colors.green,

      unselectedItemColor: Colors.grey,

      showUnselectedLabels: false,

      type: BottomNavigationBarType.fixed,
    ),
  );
}