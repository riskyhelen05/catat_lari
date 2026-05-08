import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'run.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // USER TABLE
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT,
            name TEXT
          )
        ''');

        // RUN TABLE (RELASI)
        await db.execute('''
          CREATE TABLE runs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            distance REAL,
            duration INTEGER,
            date TEXT,
            FOREIGN KEY (userId) REFERENCES users(id)
          )
        ''');
      },
    );
  }
}