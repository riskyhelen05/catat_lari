import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.directions_run,
              size: 120,
              color: Colors.blue,
            ),

            SizedBox(height: 30),

            Text(
              "Selamat Datang",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Catat aktivitas lari harianmu dengan mudah",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            Text(
          "Sudah punya akun?",
          style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          ),
          ),

            SizedBox(height: 50),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },

                child: Text("Login"),
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },

                child: Text("Daftar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}