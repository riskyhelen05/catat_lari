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

      initialRoute: '/',

      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => BottomNavScreen(),
      },
    );
  }
}