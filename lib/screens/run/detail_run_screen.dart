import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import 'edit_run_screen.dart';

class DetailRunScreen extends StatelessWidget {

  final Map<String, dynamic> run;

  const DetailRunScreen({
    super.key,
    required this.run,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Detail Lari"),
      ),

      body: Padding(

        padding: EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Card(

              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(

                padding: EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      "📅 Tanggal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      run['date']
                          .toString()
                          .split(' ')[0],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "🏃 Jarak",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text("${run['distance']} km"),

                    SizedBox(height: 20),

                    Text(
                      "⏱ Durasi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text("${run['duration']}"),

                    SizedBox(height: 20),

                    Text(
                      "📝 Catatan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      run['note'] == null ||
                              run['note'] == ""
                          ? "-"
                          : run['note'],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            Row(

              children: [

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditRunScreen(run: run),
                        ),
                      );
                    },

                    icon: Icon(Icons.edit),

                    label: Text("Edit"),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(

                  child: ElevatedButton.icon(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: () async {

                      final db =
                          await DBHelper().database;

                      await db.delete(
                        'runs',
                        where: 'id = ?',
                        whereArgs: [run['id']],
                      );

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(

                        SnackBar(
                          content: Text(
                            "Data berhasil dihapus",
                          ),
                        ),
                      );
                    },

                    icon: Icon(Icons.delete),

                    label: Text("Hapus"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}