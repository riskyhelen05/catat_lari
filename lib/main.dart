import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

import 'viewmodels/run_viewmodel.dart';

import 'views/splash/splash_screen.dart';
import 'views/navigation/bottom_nav_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';

void main() {

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => RunViewModel(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(context);

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeProvider.themeMode,

      initialRoute: '/',

      routes: {

        '/': (context) =>
            const SplashScreen(),

        '/login': (context) =>
            LoginScreen(),

        '/register': (context) =>
            RegisterScreen(),

        '/home': (context) =>
            const BottomNavScreen(),
      },
    );
  }
}