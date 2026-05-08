import 'package:flutter/material.dart';
import '../../database/auth_service.dart';
import '../../database/session.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void doLogin() async {
    var user = await authService.login(
      username.text,
      password.text,
    );

    if (user != null) {
      Session.setUser(user);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login gagal!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: doLogin,
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}