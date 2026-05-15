import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/run_viewmodel.dart';
import 'edit_run_screen.dart';

class DetailRunScreen extends StatelessWidget {

  final Map<String, dynamic> run;

  const DetailRunScreen({
    super.key,
    required this.run,
  });

  Widget buildInfoCard({

    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {

    return Card(

      elevation: 3,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Row(

          children: [

            Container(

              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(

                color: color.withOpacity(0.15),

                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    title,

                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(

                    value,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Detail Aktivitas"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            // HEADER
            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(

                gradient: const LinearGradient(

                  colors: [
                    Color(0xFF4CAF50),
                    Color(0xFF2196F3),
                  ],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius:
                    BorderRadius.circular(28),
              ),

              child: Column(

                children: [

                  const Icon(
                    Icons.directions_run,
                    color: Colors.white,
                    size: 70,
                  ),

                  const SizedBox(height: 16),

                  const Text(

                    "Running Activity",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(

                    run['date']
                        .toString()
                        .split(' ')[0],

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // INFO
            buildInfoCard(
              icon: Icons.route,
              color: Colors.green,
              title: "Jarak",
              value: "${run['distance']} km",
            ),

            buildInfoCard(
              icon: Icons.timer,
              color: Colors.orange,
              title: "Durasi",
              value: formatDuration(
                run['duration'],
              ),
            ),

            buildInfoCard(
              icon: Icons.notes,
              color: Colors.blue,
              title: "Catatan",
              value: run['note'] == null ||
                      run['note'] == ""
                  ? "-"
                  : run['note'],
            ),

            const SizedBox(height: 30),

            // BUTTON
            Row(

              children: [

                // EDIT
                Expanded(

                  child: ElevatedButton.icon(

                    style:
                        ElevatedButton.styleFrom(

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                    ),

                    onPressed: () async {

                      await Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              EditRunScreen(
                            run: run,
                          ),
                        ),
                      );

                      Navigator.pop(
                        context,
                        true,
                      );
                    },

                    icon: const Icon(Icons.edit),

                    label: const Text("Edit"),
                  ),
                ),

                const SizedBox(width: 14),

                // DELETE
                Expanded(

                  child: ElevatedButton.icon(

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor: Colors.red,

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 16,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                    ),

                    onPressed: () async {

                      final confirm =
                          await showDialog(

                        context: context,

                        builder: (_) =>
                            AlertDialog(

                          title:
                              const Text("Hapus Data"),

                          content: const Text(
                            "Yakin ingin menghapus aktivitas ini?",
                          ),

                          actions: [

                            TextButton(

                              onPressed: () {

                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },

                              child:
                                  const Text("Batal"),
                            ),

                            TextButton(

                              onPressed: () {

                                Navigator.pop(
                                  context,
                                  true,
                                );
                              },

                              child: const Text(

                                "Hapus",

                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {

                        final runVM =
                            Provider.of<
                                RunViewModel>(
                          context,
                          listen: false,
                        );

                        await runVM.deleteRun(
                          run['id'],
                        );

                        Navigator.pop(
                          context,
                          true,
                        );

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          const SnackBar(
                            content: Text(
                              "Data berhasil dihapus",
                            ),
                          ),
                        );
                      }
                    },

                    icon:
                        const Icon(Icons.delete),

                    label:
                        const Text("Hapus"),
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

String formatDuration(dynamic value) {

  final totalMinute =
      int.tryParse(value.toString()) ?? 0;

  final hour = totalMinute ~/ 60;

  final minute = totalMinute % 60;

  if (hour == 0) {

    return "$minute menit";
  }

  return "$hour jam $minute menit";
}