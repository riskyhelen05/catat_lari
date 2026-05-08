import 'package:flutter/material.dart';
import '../../database/session.dart';

class ProfileScreen extends StatelessWidget {

  void logout(BuildContext context) {
    Session.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logout(context),
          child: Text("Logout"),
        ),
      ),
    );
  }
}