import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import '../../database/session.dart';
import '../run/add_run_screen.dart';
import '../run/edit_run_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Map<String, dynamic>>> getRuns() async {
    final db = await DBHelper().database;

    return await db.query(
      'runs',
      where: 'userId = ?',
      whereArgs: [Session.userId],
      orderBy: 'id DESC',
    );
  }

  void logout(BuildContext context) {
    Session.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  // 🔥 DELETE CONFIRMATION
  void confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Hapus Data"),
        content: Text("Yakin mau hapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              final db = DBHelper();
              await db.deleteRun(id);

              Navigator.pop(context);
              setState(() {});
            },
            child: Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catat Lari"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getRuns(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return Center(
              child: Text("Belum ada data lari"),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final run = data[index];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: InkWell(
                  // 🔥 TAP = EDIT
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditRunScreen(run: run),
                      ),
                    ).then((_) => setState(() {}));
                  },

                  // 🔥 LONG PRESS = DELETE
                  onLongPress: () {
                    confirmDelete(run['id']);
                  },

                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "📅 ${run['date'].toString().split(' ')[0]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 6),

                        Text("🏃 ${run['distance']} km"),

                        Text("⏱ ${run['duration']}"),

                        if (run['note'] != null && run['note'] != "")
                          Text("📝 ${run['note']}"),

                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddRunScreen()),
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}