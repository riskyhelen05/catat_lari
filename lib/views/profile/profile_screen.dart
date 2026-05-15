import 'package:flutter/material.dart';
import '../../database/session.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Column(

          children: [

            const SizedBox(height: 20),

            CircleAvatar(

              radius: 55,

              backgroundColor: Colors.blue,

              child: Text(

                Session.username != null
                    ? Session.username![0]
                        .toUpperCase()
                    : "U",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(

              Session.username ?? "-",

              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              Session.email ?? "-",

              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            Card(

  child: Consumer<ThemeProvider>(

    builder: (context, themeProvider, child) {

      return SwitchListTile(

        secondary: const Icon(Icons.dark_mode),

        title: const Text("Dark Mode"),

        value: themeProvider.isDarkMode,

        onChanged: (value) {

          themeProvider.toggleTheme(value);
        },
      );
    },
  ),
),

            const SizedBox(height: 16),

            Card(

              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: const ListTile(

                leading: Icon(Icons.info),

                title: Text("Versi Aplikasi"),

                trailing: Text("v1.0.0"),
              ),
            ),

            const SizedBox(height: 30),

            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.green.shade100,

                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Text(

  "“Lari hari ini adalah investasi kesehatan untuk masa depan.”",

  textAlign: TextAlign.center,

  style: TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,

    color:
        Theme.of(context).brightness ==
                Brightness.dark
            ? Colors.black87
            : Colors.black87,
  ),
),
              ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

  icon: const Icon(
    Icons.logout,
    color: Colors.white,
  ),

  label: const Text(
    "Logout",
    style: TextStyle(
      color: Colors.white,
    ),
  ),

  style: ElevatedButton.styleFrom(

    backgroundColor: Colors.red,

    padding: const EdgeInsets.symmetric(
      vertical: 16,
    ),

    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(18),
    ),
  ),

  onPressed: () {

    Session.clear();

    Navigator.pushNamedAndRemoveUntil(

      context,

      '/login',

      (route) => false,
    );
  },
),
            ),
          ],
        ),
      ),
    );
  }
}