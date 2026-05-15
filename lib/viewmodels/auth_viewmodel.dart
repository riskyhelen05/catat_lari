import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {

  final AuthService _authService =
      AuthService();

  Future<Map<String, dynamic>?> login({

    required String username,
    required String password,

  }) async {

    return await _authService.login(
      username,
      password,
    );
  }

  Future<int> register({

    required String username,
    required String email,
    required String password,

  }) async {

    return await _authService.register(

      username,
      email,
      password,
    );
  }
}