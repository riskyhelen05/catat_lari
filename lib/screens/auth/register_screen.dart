import 'package:flutter/material.dart';
import '../../database/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  final username = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  void register(BuildContext context) async {
    await authService.register(
      username.text,
      password.text,
      name.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: username, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: password, decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}