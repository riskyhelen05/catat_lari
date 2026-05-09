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

              return Dismissible(
  key: Key(run['id'].toString()),

  direction: DismissDirection.endToStart,

  background: Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    padding: EdgeInsets.only(right: 20),

    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(12),
    ),

    alignment: Alignment.centerRight,

    child: Icon(
      Icons.delete,
      color: Colors.white,
      size: 30,
    ),
  ),

  confirmDismiss: (direction) async {

    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Hapus Data"),
        content: Text("Yakin ingin menghapus data lari ini?"),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Batal"),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),

        ],
      ),
    );
  },

  onDismissed: (direction) async {

    final deletedRun = Map<String, dynamic>.from(run);

    final db = await DBHelper().database;

    await db.delete(
      'runs',
      where: 'id = ?',
      whereArgs: [run['id']],
    );

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text("Data berhasil dihapus"),

        action: SnackBarAction(

          label: "UNDO",

          onPressed: () async {

            await db.insert(
              'runs',
              deletedRun,
            );

            setState(() {});
          },
        ),

        duration: Duration(seconds: 3),
      ),
    );

    setState(() {});
  },

  child: Card(

    elevation: 3,

    margin: EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),

    child: InkWell(

      borderRadius: BorderRadius.circular(12),

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditRunScreen(run: run),
          ),
        ).then((_) => setState(() {}));
      },

      child: Padding(

        padding: EdgeInsets.all(14),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "📅 ${run['date'].toString().split(' ')[0]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "🏃 ${run['distance']} km",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 4),

            Text(
              "⏱ ${run['duration']}",
              style: TextStyle(fontSize: 16),
            ),

            if (run['note'] != null &&
                run['note'] != "")
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  "📝 ${run['note']}",
                ),
              ),
          ],
        ),
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