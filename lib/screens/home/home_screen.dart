import 'package:flutter/material.dart';

import '../../database/db_helper.dart';
import '../../database/session.dart';

import '../run/add_run_screen.dart';
import '../run/detail_run_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 🔥 AMBIL DATA LARI
  Future<List<Map<String, dynamic>>> getRuns() async {

    final db = await DBHelper().database;

    return await db.query(
      'runs',
      where: 'userId = ?',
      whereArgs: [Session.userId],
      orderBy: 'id DESC',
    );
  }

  // 🔥 STATISTIK
  Future<Map<String, dynamic>> getStatistics() async {

    final db = await DBHelper().database;

    final result = await db.rawQuery('''
      SELECT
        COUNT(*) as totalRun,
        SUM(distance) as totalDistance
      FROM runs
      WHERE userId = ?
    ''', [Session.userId]);

    return result.first;
  }

  // 🔥 LOGOUT
  void logout(BuildContext context) {

    Session.clear();

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Catat Lari"),
        centerTitle: true,
      ),

      body: FutureBuilder<Map<String, dynamic>>(

        future: getStatistics(),

        builder: (context, statSnapshot) {

          if (!statSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final stats = statSnapshot.data!;

          return Column(

            children: [

              // 🔥 GREETING USER
              Padding(

                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),

                child: Row(

                  children: [

                    CircleAvatar(

                      radius: 26,

                      backgroundColor: Color(0xFF2196F3),

                      child: Text(

                        Session.username != null
                            ? Session.username![0]
                                .toUpperCase()
                            : "U",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(width: 14),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Halo, ${Session.username ?? 'User'} 👋",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Siap untuk lari hari ini?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // 🔥 DASHBOARD GRADIENT
              Container(

                margin: EdgeInsets.all(16),

                padding: EdgeInsets.all(20),

                decoration: BoxDecoration(

                  gradient: LinearGradient(

                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF4CAF50),
                    ],

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius:
                      BorderRadius.circular(24),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // 🔥 HEADER
                    Row(

                      children: [

                        CircleAvatar(

                          radius: 24,

                          backgroundColor: Colors.white,

                          child: Icon(
                            Icons.directions_run,
                            color: Color(0xFF2196F3),
                            size: 28,
                          ),
                        ),

                        SizedBox(width: 14),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                "Tetap Semangat 💪",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                "Jaga kesehatan dengan rutin berolahraga",
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // 🔥 STATISTIK
                    Row(

                      children: [

                        // TOTAL RUN
                        Expanded(

                          child: Container(

                            padding: EdgeInsets.all(16),

                            decoration: BoxDecoration(

                              color: Colors.white
                                  .withOpacity(0.2),

                              borderRadius:
                                  BorderRadius.circular(18),
                            ),

                            child: Column(

                              children: [

                                Icon(
                                  Icons.flag,
                                  color: Colors.white,
                                  size: 28,
                                ),

                                SizedBox(height: 8),

                                Text(
                                  "${stats['totalRun'] ?? 0}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "Total Run",
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 14),

                        // TOTAL DISTANCE
                        Expanded(

                          child: Container(

                            padding: EdgeInsets.all(16),

                            decoration: BoxDecoration(

                              color: Colors.white
                                  .withOpacity(0.2),

                              borderRadius:
                                  BorderRadius.circular(18),
                            ),

                            child: Column(

                              children: [

                                Icon(
                                  Icons.route,
                                  color: Colors.white,
                                  size: 28,
                                ),

                                SizedBox(height: 8),

                                Text(
                                  "${(stats['totalDistance'] ?? 0).toString()} km",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "Distance",
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 🔥 MOTIVATIONAL BANNER
              Container(

                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                padding: EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.orange.shade100,

                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(
                    color: Colors.orange.shade300,
                  ),
                ),

                child: Row(

                  children: [

                    Icon(
                      Icons.favorite,
                      color: Colors.orange,
                      size: 34,
                    ),

                    SizedBox(width: 14),

                    Expanded(

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Hidup Sehat 🌿",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Lari rutin membantu menjaga kesehatan tubuh dan pikiran.",
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              // 🔥 LIST DATA
              Expanded(

                child: FutureBuilder<List<Map<String, dynamic>>>(

                  future: getRuns(),

                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.data!;

                    if (data.isEmpty) {

                      return Center(

                        child: Column(

                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            Icon(
                              Icons.directions_run,
                              size: 80,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Belum ada data lari",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              "Yuk mulai catat aktivitas larimu 🚀",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(

                      itemCount: data.length,

                      itemBuilder: (context, index) {

                        final run = data[index];

                        return Dismissible(

                          key: Key(
                            run['id'].toString(),
                          ),

                          direction:
                              DismissDirection.endToStart,

                          background: Container(

                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            padding: EdgeInsets.only(
                              right: 20,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),

                            alignment:
                                Alignment.centerRight,

                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          // 🔥 KONFIRMASI DELETE
                          confirmDismiss:
                              (direction) async {

                            return await showDialog(

                              context: context,

                              builder: (_) => AlertDialog(

                                title:
                                    Text("Hapus Data"),

                                content: Text(
                                  "Yakin ingin menghapus data ini?",
                                ),

                                actions: [

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(
                                        context,
                                        false,
                                      );
                                    },

                                    child: Text("Batal"),
                                  ),

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(
                                        context,
                                        true,
                                      );
                                    },

                                    child: Text(

                                      "Hapus",

                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },

                          // 🔥 DELETE + UNDO
                          onDismissed:
                              (direction) async {

                            final deletedRun =
                                Map<String, dynamic>
                                    .from(run);

                            final db =
                                await DBHelper()
                                    .database;

                            await db.delete(

                              'runs',

                              where: 'id = ?',

                              whereArgs: [
                                run['id']
                              ],
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(

                              SnackBar(

                                content: Text(
                                  "Data berhasil dihapus",
                                ),

                                action:
                                    SnackBarAction(

                                  label: "UNDO",

                                  onPressed: () async {

                                    await db.insert(
                                      'runs',
                                      deletedRun,
                                    );

                                    setState(() {});
                                  },
                                ),
                              ),
                            );

                            setState(() {});
                          },

                          // 🔥 RUN CARD
                          child: Card(

                            elevation: 4,

                            margin: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(22),
                            ),

                            child: InkWell(

                              borderRadius:
                                  BorderRadius.circular(22),

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        DetailRunScreen(
                                      run: run,
                                    ),
                                  ),
                                ).then(
                                  (_) => setState(() {}),
                                );
                              },

                              child: Padding(

                                padding:
                                    EdgeInsets.all(18),

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    // 🔥 HEADER
                                    Row(

                                      children: [

                                        Container(

                                          padding:
                                              EdgeInsets
                                                  .all(12),

                                          decoration:
                                              BoxDecoration(

                                            color: Colors
                                                .blue
                                                .shade100,

                                            borderRadius:
                                                BorderRadius.circular(
                                                    16),
                                          ),

                                          child: Icon(
                                            Icons
                                                .directions_run,
                                            color:
                                                Colors.blue,
                                            size: 28,
                                          ),
                                        ),

                                        SizedBox(width: 14),

                                        Expanded(

                                          child: Column(

                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,

                                            children: [

                                              Text(
                                                "Running Activity",
                                                style:
                                                    TextStyle(
                                                  fontSize:
                                                      17,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),

                                              SizedBox(
                                                  height: 4),

                                              Text(
                                                run['date']
                                                    .toString()
                                                    .split(
                                                        ' ')[0],
                                                style:
                                                    TextStyle(
                                                  color:
                                                      Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Icon(
                                          Icons
                                              .arrow_forward_ios,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 18),

                                    // 🔥 STATS
                                    Row(

                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceAround,

                                      children: [

                                        // DISTANCE
                                        Column(

                                          children: [

                                            Icon(
                                              Icons.route,
                                              color:
                                                  Colors.green,
                                            ),

                                            SizedBox(
                                                height: 6),

                                            Text(
                                              "${run['distance']} km",
                                              style:
                                                  TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),

                                            SizedBox(
                                                height: 2),

                                            Text(
                                              "Distance",
                                              style:
                                                  TextStyle(
                                                color:
                                                    Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // DURATION
                                        Column(

                                          children: [

                                            Icon(
                                              Icons.timer,
                                              color:
                                                  Colors.orange,
                                            ),

                                            SizedBox(
                                                height: 6),

                                            Text(
                                              "${run['duration']}",
                                              style:
                                                  TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),

                                            SizedBox(
                                                height: 2),

                                            Text(
                                              "Duration",
                                              style:
                                                  TextStyle(
                                                color:
                                                    Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // 🔥 NOTE
                                    if (run['note'] !=
                                            null &&
                                        run['note'] != "")

                                      Padding(

                                        padding:
                                            EdgeInsets.only(
                                          top: 18,
                                        ),

                                        child: Container(

                                          width:
                                              double.infinity,

                                          padding:
                                              EdgeInsets.all(
                                                  14),

                                          decoration:
                                              BoxDecoration(

                                            color: Colors
                                                .grey
                                                .shade100,

                                            borderRadius:
                                                BorderRadius.circular(
                                                    14),
                                          ),

                                          child: Row(

                                            children: [

                                              Icon(
                                                Icons.notes,
                                                color:
                                                    Colors.grey,
                                              ),

                                              SizedBox(
                                                  width: 10),

                                              Expanded(

                                                child: Text(
                                                  run['note'],
                                                  style:
                                                      TextStyle(
                                                    color: Colors
                                                        .black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
              ),
            ],
          );
        },
      ),

      // 🔥 TAMBAH DATA
      floatingActionButton: FloatingActionButton(

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) => AddRunScreen(),
            ),
          ).then((_) => setState(() {}));
        },

        child: Icon(Icons.add),
      ),
    );
  }
}