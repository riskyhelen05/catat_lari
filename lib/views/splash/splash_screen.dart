import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> fadeAnimation;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    controller.forward();

    Timer(

      const Duration(seconds: 3),

      () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Color(0xFF4CAF50),
              Color(0xFF2196F3),
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: FadeTransition(

          opacity: fadeAnimation,

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Container(

                padding: const EdgeInsets.all(28),

                decoration: BoxDecoration(

                  color: Colors.white,

                  shape: BoxShape.circle,

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.directions_run,
                  size: 90,
                  color: Color(0xFF4CAF50),
                ),
              ),

              const SizedBox(height: 30),

              const Text(

                "Catat Lari",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                "Healthy Lifestyle Tracker",

                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 50),

              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}