import 'package:flutter/material.dart';

import '../../database/session.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Profile"),
      ),

      body: Padding(

        padding: EdgeInsets.all(24),

        child: Column(

          children: [

            SizedBox(height: 20),

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            Text(
              Session.username ?? "-",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              Session.email ?? "-",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 40),

            Card(

              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: ListTile(

                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),

                title: Text("Logout"),

                onTap: () {

                  Session.clear();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
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