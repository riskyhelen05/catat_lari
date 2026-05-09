import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/navigation/bottom_nav_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

  debugShowCheckedModeBanner: false,

  theme: ThemeData(

    brightness: Brightness.light,

    primarySwatch: Colors.green,

    scaffoldBackgroundColor: Color(0xFFF5F7FA),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),

    cardTheme: CardThemeData(

      color: Colors.white,

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),

  // 🔥 DARK MODE
  darkTheme: ThemeData(

    brightness: Brightness.dark,

    primarySwatch: Colors.green,

    scaffoldBackgroundColor: Color(0xFF121212),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      centerTitle: true,
    ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),

    cardTheme: CardThemeData(

      color: Color(0xFF1E1E1E),

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),

  themeMode: ThemeMode.system,

  initialRoute: '/',

  routes: {

    '/': (context) => SplashScreen(),

    '/home': (context) => BottomNavScreen(),
  },
);
  }
}