import 'package:flutter/material.dart';

import '../../data/user_data.dart';

import '../../database/db_helper.dart';

import '../../database/session.dart';

import '../navigation/bottom_nav_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = true;

  void doLogin() async {

  String emailText = emailController.text.trim();
  String passwordText = passwordController.text.trim();

  if (emailText.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Email wajib diisi"),
      ),
    );

    return;
  }

  if (passwordText.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Password wajib diisi"),
      ),
    );

    return;
  }

  final db = await DBHelper().database;

  final result = await db.query(
    'users',

    where: 'email = ? AND password = ?',

    whereArgs: [
      emailText,
      passwordText,
    ],
  );

  if (result.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Email atau password salah"),
      ),
    );

    return;
  }

  final user = result.first;

// simpan ke session
Session.setUser(user);

print("User login: ${Session.userId}");

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Login berhasil"),
  ),
);

Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const BottomNavScreen(),
  ),
);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Login"),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              SizedBox(height: 40),

              Text(
                "Selamat Datang 👋",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Silakan login ke akunmu",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 40),

              TextField(
                controller: emailController,

                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: isHidden,

                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),

                  suffixIcon: IconButton(
                    onPressed: () {

                      setState(() {
                        isHidden = !isHidden;
                      });
                    },

                    icon: Icon(
                      isHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              SizedBox(
  width: double.infinity,

  child: ElevatedButton(
    onPressed: doLogin,

    child: Text("Login"),
  ),
),

const SizedBox(height: 20),

Row(
  mainAxisAlignment: MainAxisAlignment.center,

  children: [

    const Text("Belum punya akun?"),

    TextButton(
      onPressed: () {

        Navigator.pushNamed(
          context,
          '/register',
        );
      },

      child: const Text("Daftar"),
    ),
  ],
),
            ],
          ),
        ),
      ),
    );
  }
}