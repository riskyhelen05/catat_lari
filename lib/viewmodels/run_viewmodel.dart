import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../database/session.dart';

class RunViewModel extends ChangeNotifier {

  final DBHelper _dbHelper = DBHelper();

  List<Map<String, dynamic>> runs = [];

  bool isLoading = false;

  double totalDistance = 0;

  int totalRun = 0;

  // LOAD RUNS
  Future<void> fetchRuns() async {

    isLoading = true;
    notifyListeners();

    final db = await _dbHelper.database;

    runs = await db.query(
      'runs',
      where: 'userId = ?',
      whereArgs: [Session.userId],
      orderBy: 'id DESC',
    );

    calculateStatistics();

    isLoading = false;
    notifyListeners();
  }

  // TOTAL
  void calculateStatistics() {

    totalDistance = 0;

    totalRun = runs.length;

    for (var run in runs) {

      totalDistance +=
          double.parse(run['distance'].toString());
    }
  }

  // ADD RUN
Future<void> addRun({
  required int userId,
  required double distance,
  required String duration,
  required String note,
  required String date,
}) async {

  final db = DBHelper();

  await db.insertRun({

    'userId': userId,
    'distance': distance,
    'duration': duration,
    'note': note,
    'date': date,
  });

  await fetchRuns();
}

  // UPDATE RUN
  Future<void> updateRun(
    int id,
    Map<String, dynamic> data,
  ) async {

    await _dbHelper.updateRun(id, data);

    await fetchRuns();
  }

  // DELETE RUN
  Future<void> deleteRun(int id) async {

    final db = await _dbHelper.database;

    await db.delete(
      'runs',
      where: 'id = ?',
      whereArgs: [id],
    );

    await fetchRuns();
  }
}