import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../../database/db_helper.dart';
import '../../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nama = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  void doRegister() async {

  String usernameText = username.text.trim();
  String emailText = email.text.trim();
  String passwordText = password.text.trim();
  String confirmText = confirmPassword.text.trim();

  if (
  usernameText.isEmpty ||
      emailText.isEmpty ||
      passwordText.isEmpty ||
      confirmText.isEmpty
  ) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Semua field wajib diisi"),
      ),
    );

    return;
  }

  if (!emailText.contains("@")) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Email tidak valid"),
      ),
    );

    return;
  }

  if (passwordText.length < 6) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Password minimal 6 karakter"),
      ),
    );

    return;
  }

  if (passwordText != confirmText) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Konfirmasi password tidak sama"),
      ),
    );

    return;
  }

  final db = await DBHelper().database;

  User user = User(
    username: usernameText,
    email: emailText,
    password: passwordText,
  );

  await db.insert(
    'users',
    user.toMap(),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Register berhasil"),
    ),
  );

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Daftar"),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(24),

          child: Column(
            children: [

              SizedBox(height: 20),

              TextField(
                controller: username,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: password,
                obscureText: isPasswordHidden,

                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),

                  suffixIcon: IconButton(
                    onPressed: () {

                      setState(() {
                      isPasswordHidden = !isPasswordHidden;
                      });
                    },

                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: confirmPassword,
                obscureText: isConfirmHidden,

                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {

                      setState(() {
                      isConfirmHidden = !isConfirmHidden;
                      });
                    },

                    icon: Icon(
                      isConfirmHidden
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
    onPressed: doRegister,
    child: Text("Daftar"),
  ),
),

const SizedBox(height: 20),

Row(
  mainAxisAlignment: MainAxisAlignment.center,

  children: [

    const Text("Sudah punya akun?"),

    TextButton(
      onPressed: () {

        Navigator.pop(context);
      },

      child: const Text("Login"),
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