import 'package:sqflite/sqflite.dart';

import '../database/db_helper.dart';

class AuthService {

  final DBHelper dbHelper = DBHelper();

  // REGISTER
  Future<int> register(

    String username,
    String email,
    String password,

  ) async {

    final db = await dbHelper.database;

    return await db.insert('users', {

      'username': username,

      'email': email,

      'password': password,
    });
  }

  // LOGIN
  Future<Map<String, dynamic>?> login(

    String username,
    String password,

  ) async {

    final db = await dbHelper.database;

    List<Map<String, dynamic>> result =
        await db.query(

      'users',

      where:
          'email = ? AND password = ?',

      whereArgs: [
        username,
        password,
      ],
    );

    if (result.isNotEmpty) {

      return result.first;
    }

    return null;
  }
}