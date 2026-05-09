import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(
      await getDatabasesPath(),
      'catat_lari.db',
    );

    return await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE runs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            distance REAL,
            duration TEXT,
            note TEXT,
            date TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS users');
        await db.execute('DROP TABLE IF EXISTS runs');

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            email TEXT,
            password TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE runs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            distance REAL,
            duration TEXT,
            note TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  // 🔥 HARUS DI DALAM CLASS (INI YANG TADI SALAH)
  Future<int> insertRun(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('runs', data);
  }

  Future<int> updateRun(int id, Map<String, dynamic> data) async {
  final db = await database;
  return await db.update(
    'runs',
    data,
    where: 'id = ?',
    whereArgs: [id],
  );
}
}